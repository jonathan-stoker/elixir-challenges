defmodule ControlFlowChapter do
# Chapter 12 (Programming Elixir)
# Exercise 1: Rewrite the FizzBuzz example using case.

def fizzbuzz(number) when number > 0 do
  1..number |> Enum.map(&fb_case/1)
end

defp fb_case(number) do
  case number do
    number when rem(number, 3) == 0 and rem(number, 5) == 0 ->
      "FizzBuzz"
    number when rem(number, 5) == 0 ->
      "Fizz"
    number when rem(number, 3) == 0 ->
      "Buzz"
    _ ->
      number
    end
end

# Exercise 3: Write an ok! function that takes an arbitrary parameter. If the parameter is the tuple {:ok, data},
# return the data. Otherwise, raise an exception containing information from the parameter.
# You could use your function like this:
# file = ok! File.open("somefile")

def ok!(data) do
  case data do
    data when data == {:ok, data} ->
      data
    data when data == {:error, data} ->
      raise RuntimeError, message: "Failed to open file."
    _ ->
      raise RuntimeError, message: "Unknown data"
  end
end


end
