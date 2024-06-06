defmodule BinariesChapter do

  # Write a function that returns true if a single-quoted string contains only printable ASCII
  # characters (space through tilde).
  def check_printable([]), do: "This character string contains all printable ASCII characters!"

  def check_printable([ char | tail ])
  when char in 32..126 do
    check_printable(tail)
  end

  def check_printable([ _char | _tail]), do: "This character string is not printable!"

  def check_printable(_str), do: "Invalid input!  This function is for testing character strings!
  (Single quoted)"


  #   Write an anagram?(word1, word2) that returns true if its parameters are anagrams.
  def anagram(word1, word2), do: anagram_checker(word1, word2, 0)

  defp anagram_checker(word1, word2, 0) do
    check1 = for char <- word1, char not in word2, do: char
    if check1 == [] do
      anagram_checker(word1, word2, 1)
    else
      "These two words are not anagrams! (check1)"
    end
  end

  defp anagram_checker(word1, word2, 1) do
    check2 = for char <- word2, char not in word1, do: char
    if check2 == [] do
      "These two words ARE anagrams! Hooray!"
    else
      "These two words are not anagrams! (check2)"
    end
  end


  # Hard) Write a function that takes a single-quoted string of the form number [+-*/] number and
  # returns the result of the calculation. The individual numbers do not have leading plus or minus
  # signs.

  def string_calc(single_quoted_string) do
    op_check = for char <- single_quoted_string, char in [42, 43, 47, 45], do: char
    case op_check do
      op_check when length(op_check) > 1 -> "You can only include one operator (+, -, *, or /).  Please try again."
      op_check when length(op_check) == 1 -> split_string_on_operator(op_check, single_quoted_string)
      _ -> "You didn't enter a valid operator (+, -, *, or /).  Please try again."
    end
  end

  defp split_string_on_operator(operator, single_quoted_string) do
    {first_number, second_number_with_operator} =
      Enum.split(single_quoted_string, Enum.find_index(single_quoted_string, fn x -> x == Enum.min(operator) end))
    second_number = Enum.drop(second_number_with_operator, 1)
    do_the_math(first_number, second_number, operator)
  end

  defp do_the_math(first_number, second_number, operator) do
    first_number_integer = List.to_integer(first_number)
    second_number_integer = List.to_integer(second_number)
    operator_ascii_integer = Enum.min(operator)
    case operator_ascii_integer do
      operator_ascii_integer when operator_ascii_integer == 42 ->
        result = first_number_integer * second_number_integer
        "#{first_number_integer} * #{second_number} = #{result}"
      operator_ascii_integer when operator_ascii_integer == 43 ->
        result = first_number_integer + second_number_integer
        "#{first_number_integer} + #{second_number} = #{result}"
      operator_ascii_integer when operator_ascii_integer == 45 ->
        result = first_number_integer - second_number_integer
        "#{first_number_integer} - #{second_number} = #{result}"
      operator_ascii_integer when operator_ascii_integer == 47 ->
        result = first_number_integer / second_number_integer
        "#{first_number_integer} / #{second_number} = #{result}"
    end

  end


  # Write a function that takes a list of double-quoted strings and prints each on a separate line, centered in a column that has the
  # width of the longest string. Make sure it works with UTF characters.

  def center(list) do
    max_length =
      String.length(Enum.at(
        Enum.sort(list, &(String.length(&1) >= String.length(&2))), 0))
    print_centered(max_length, list)
  end

  defp print_centered(_max_length, []), do: :ok

  defp print_centered(max_length, [head | tail]) do
    difference =
      max_length - String.length(head)
    string_with_padding =
      round(difference / 2) + String.length(head)
    IO.puts("#{String.pad_leading(head, string_with_padding)}")
    print_centered(max_length, tail)
  end


  # Exercise 6: Write a function to capitalize the sentences in a string. Each sentence is terminated by a period and a space. Right now,
  # the case of the characters in the string is random.  Ex: BinariesChapter.format_and_capitalize("oh. a DOG. woof. ")

  def format_and_capitalize(sentence_string) when is_binary(sentence_string) do
    formatting_list =
      String.split(sentence_string, ~r{\.\s})
    if Enum.count(formatting_list) > 1 do
      Enum.drop(formatting_list, -1)
    end
    if Enum.count(formatting_list) > 1 do
      sentence_list = ["#{String.capitalize(Enum.at(formatting_list, 0))}."]
      capitilized_remaining_sentences =
        for sentence <- formatting_list, Enum.find_index(formatting_list, fn x -> x == sentence end) != 0, do: " #{String.capitalize(sentence)}."
      sentence_list = [capitilized_remaining_sentences | sentence_list]
      List.to_string(Enum.reverse(sentence_list))
    else
      "#{String.capitalize(Enum.at(formatting_list, 0))}"
    end
  end

  # Write a function that reads and parses this file and then passes the result to the sales_tax function. Remember that the data should be formatted
  # into a keyword list, and that the fields need to be the correct types (so the id field is an integer, and so on).
  # BinariesChapter.sales_parser("./sales_information.csv").  Output should be a list of keyword lists.

  def sales_parser(path_to_file) when is_binary(path_to_file) do
    {:ok, contents} = File.read(path_to_file)
    formatting_list =
      String.split(contents, ~r{\r\n})
    orders_as_kl =
      for [id, ship_to, net_amount] <- formatting_list, Enum.find_index(formatting_list, fn x -> x == [id, ship_to, net_amount] end) != 0, do: [id: id, ship_to: ship_to, net_amount: net_amount]
  end


end
