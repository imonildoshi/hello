alias Hello.Publisher

defmodule Hello do
  @moduledoc """
  Provides a function `double/1` to double a number
  """

  @doc """
  Double a number

  ## Parameters

    - number: Number that needs to be double.

  ## Examples

      iex> Hello.double(4)
      8

      iex> Hello.double(2)
      4

  """
  @spec double(number) :: number
  def double(number) do
    number * 2
  end

  @doc """
  Push key value to redis

  ## Parameters

    - key: Key to be pushed in redis
    - value: Value of key to pushed

  ## Examples

      iex> Hello.push("monil", "doshi")
      {:ok, "OK"}
  """

  @spec push(String.t(), String.t()) :: {:ok, String.t()}
  def push(key, value) do
    Publisher.publish_message("#{key} == #{value}", "#")
    Redix.command(:redix, ["SET", key, value])
  end
end
