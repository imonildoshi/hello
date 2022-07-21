ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Hello.Repo, :manual)

defmodule HelloTest do
  use ExUnit.Case, async: true
  doctest Hello
end
