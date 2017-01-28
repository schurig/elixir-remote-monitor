defmodule RemoteMonitor.Mixfile do
  use Mix.Project

  def project do
    [app: :remote_monitor,
     version: "1.0.0",
     elixir: "~> 1.3",
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
    [applications: [:bunt, :logger]]
  end

  defp deps do
    [
      {:sshex, "2.1.0"},
      {:bunt, "~> 0.2.0"},
      {:credo, "~> 0.6.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:inch_ex, "~> 0.5.3", only: [:dev, :test, :docs]}
    ]
  end

  defp aliases do
    [
      # "credo": ["credo --strict"]
    ]
  end
end
