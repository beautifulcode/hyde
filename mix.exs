defmodule Hyde.Mixfile do
  use Mix.Project

  def project do
    [app: :hyde,
     version: "0.0.1",
     elixir: "~> 1.1",
     description: "Feature Toggles for Elixir - Basic Redis backed feature
     toggles for individual users or named groups",
     maintainers: "Aaron Glenn",
     licences: "MIT",
     links: %{github: "https://github.com/beautifulcode/hyde"},
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:exredis, "~> 0.2"},
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end
