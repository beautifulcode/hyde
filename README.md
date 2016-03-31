# Hyde

Simple feature toggling lib that wraps Redis and integrates with Phoenix

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add hyde to your list of dependencies in `mix.exs`:

        def deps do
          [{:hyde, "~> 0.0.1"}]
        end

  2. Ensure hyde is started before your application:

        def application do
          [applications: [:hyde]]
        end
