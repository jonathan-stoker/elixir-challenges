defmodule ControlFlowChapter do

# Rewrite the FizzBuzz example using case.

def case_test(number) do
  case number do
    check_fizzbuzz = number when rem(number, 3) == 0 and rem(number, 5) == 0 ->
      "FizzBuzz"
    check_fizz = number when rem(number, 5) == 0 ->
      "Fizz"
    check_buzz = number when rem(number, 3) == 0 ->
      "Buzz"
    _ ->
      number
    end
end


end
