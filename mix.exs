defmodule RemoteMonitor.Mixfile do
  use Mix.Project

  def project do
    [app: :remote_monitor,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "elixir-remote-monitor",
     description: "A Mix task that helps you to observe your remote elixir nodes from your local machine.",
     package: package()
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["Martin Schurig"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/schurig/elixir-remote-monitor"},
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:sshex, "2.1.0"}]
  end
end
