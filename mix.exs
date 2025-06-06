defmodule IGot99Problems.MixProject do
  use Mix.Project

  def project do
    [
      app: :i_got_99_problems,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.38.2", only: :dev, runtime: false, warn_if_outdated: true},
      {:rexbug, ">= 2.0.0-rc1"}
    ]
  end
end
