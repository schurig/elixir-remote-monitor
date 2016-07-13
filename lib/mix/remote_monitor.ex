defmodule Mix.Tasks.RemoteMonitor do
  use Mix.Task

  def run(args) do
    [remote, app_cookie] = args
    [user, host] = String.split(remote, "@")

    :ssh.start
    case SSHEx.connect(ip: String.to_charlist(host), user: String.to_charlist(user)) do
      {:ok, conn} -> observe!(conn, "#{user}@#{host}", app_cookie)
      {:error, reason} -> throw reason
    end
  end

  def observe!(conn, remote_host, erlang_cookie) do
    [app_port, epmd_port] = node_info(conn, erlang_cookie)
    clean_up!(app_port, epmd_port)
    start_tunnel!(remote_host, app_port, epmd_port)
    start_observer!(erlang_cookie)
  end

  defp node_info(conn, erlang_cookie) do
    result = SSHEx.cmd!(conn, 'epmd -names')
    [[epmd_res]] = Regex.scan(~r/epmd: up and running on port [0-9]+ with data/, result)
    [[epmd_port]] = Regex.scan(~r/[0-9]+/, epmd_res)
    [[app_res]] = Regex.scan(~r/name #{erlang_cookie} at port [0-9]+/, result)
    [[app_port]] = Regex.scan(~r/[0-9]+/, app_res)
    [app_port, epmd_port]
  end

  defp clean_up!(app_port, epmd_port) do
    [:dimgray, "# Cleaning up old tunnels.."]
    |> Bunt.puts

    Mix.shell.cmd("lsof -wni tcp:#{app_port} -t | xargs kill -9")
    Mix.shell.cmd("lsof -wni tcp:#{epmd_port} -t | xargs kill -9")
  end

  defp start_tunnel!(remote_host, app_port, epmd_port) do
    spawn(fn ->
      [:dimgray, "# Setting up SSH tunnel.."]
      |> Bunt.puts

      Mix.shell.cmd("ssh -L #{app_port}:localhost:#{app_port} -L #{epmd_port}:localhost:#{epmd_port} #{remote_host} -f -N")
    end)
  end

  defp start_observer!(erlang_cookie) do
    [:dimgray, "# Starting observer.."]
    |> Bunt.puts

    ["\n\n", :red, :bright, "Instructions"]
    |> Bunt.puts

    [:darkred, "1. Connect to node \"#{erlang_cookie}@127.0.0.1\" by using the UI"]
    |> Bunt.puts
    [:darkred, "2. 😊", "\n\n"]
    |> Bunt.puts

    [:dimgray, "Issues & Feature requests: github.com/schurig/elixir-remote-monitor/issues/new", "\n"]
    |> Bunt.puts

    Mix.shell.cmd("erl -name debug@127.0.0.1 -setcookie #{erlang_cookie} -run observer")
  end
end
