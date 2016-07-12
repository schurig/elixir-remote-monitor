defmodule RemoteMonitor.Mixfile do
  use Mix.Project

  def project do
    [app: :remote_monitor,
     version: "0.1.2",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "elixir-remote-monitor",
     description: "A Mix task that helps you to observe your remote elixir nodes from your local machine.",
     package: package(),
     aliases: aliases()
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*", "CHANGELOG.md"],
      maintainers: ["Martin Schurig"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/schurig/elixir-remote-monitor"},
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:sshex, "2.1.0"},
      {:credo, "~> 0.4.5", only: [:dev, :test]},
      {:inch_ex, only: [:dev, :test, :docs]}
    ]
  end

  defp aliases do
    [
      # "credo": ["credo --strict"]
    ]
  end
end
