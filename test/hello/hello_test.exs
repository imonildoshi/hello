defmodule Hello.HelloTest do
  use Hello.DataCase

  test "Double an integer" do
    assert 4 = Hello.double(2)
  end

  test "Double: Error when string is passed" do
    assert_raise ArithmeticError, fn ->
      Hello.double("string passed")
    end
  end
end
