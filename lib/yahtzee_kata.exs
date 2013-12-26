defmodule Yahtzee do
  def score('Pair', rolls) do
    Enum.sort(rolls)
    |> find_pairs([])
    |> Enum.max
    |> sum
  end
  
  def score(category, rolls) do
    match_roll(rolls, category_to_number(category), [])
    |> sum
  end

  defp find_pairs([], pairs), do: pairs

  defp find_pairs(rolls, pairs) do
    [head | tail] = rolls
    pairs = Enum.filter(rolls, &(head == &1))
    find_pairs(tail, pairs)
  end

  defp match_roll([], roll_to_match, matches), do: matches

  defp match_roll([head | tail], roll_to_match, matches) when head == roll_to_match do
    match_roll(tail, roll_to_match, Enum.concat(matches, [head]))
  end

  defp match_roll([head | tail], roll_to_match, matches) when head != roll_to_match do
    match_roll(tail, roll_to_match, matches)
  end

  defp sum(rolls), do: _sum(rolls, 0)
  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)

  defp category_to_number('Ones'),   do: 1
  defp category_to_number('Twos'),   do: 2
  defp category_to_number('Threes'), do: 3
  defp category_to_number('Fours'),  do: 4
  defp category_to_number('Fives'),  do: 5
  defp category_to_number('Sixes'),  do: 6
end