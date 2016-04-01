defmodule Hyde.Mixfile do
  use Mix.Project

  def project do
    [app: :hyde,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:exredis, "~> 0.2"},
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  defp description do
    """
    Feature Toggles for Elixir - Basic Redis backed feature toggles for individual users or named groups
    """
  end

  defp package do
    [
     maintainers: ["Aaron Glenn"],
     licences: ["MIT"],
     links: %{"Github" => "https://github.com/beautifulcode/hyde"}
    ]
  end
end
