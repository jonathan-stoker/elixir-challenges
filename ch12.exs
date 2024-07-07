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


end
