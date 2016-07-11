# Elixir Remote Monitor [![Inline docs](http://inch-ci.org/github/schurig/elixir-remote-monitor.svg)](http://inch-ci.org/github/schurig/elixir-remote-monitor) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/schurig/elixir-remote-monitor.svg)](https://beta.hexfaktor.org/github/schurig/elixir-remote-monitor) [![Deps Status](https://beta.hexfaktor.org/badge/prod/github/schurig/elixir-remote-monitor.svg)](https://beta.hexfaktor.org/github/schurig/elixir-remote-monitor) [![Hex.pm](https://img.shields.io/hexpm/v/remote_monitor.svg?maxAge=2592000)]()


A Mix task that helps you to observe your remote elixir nodes from your local machine.

It finds out the ports your remote Elixir node is running on, binds them to your local machine and starts the erlang observer for you.

## Installation

Add `remote_monitor` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:remote_monitor, "~> 0.1.0", only: :dev}]
  end
  ```

## Usage

`$ mix remote_monitor user@example.com your_app_cookie`

Follow the instructions in the console.
