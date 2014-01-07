defmodule Yahtzee do
  def score('Pair', rolls) do
    Enum.sort(rolls)
    |> score_pairs([])
    |> sum
  end
  
  def score(category, rolls) do
    match_roll(rolls, category_to_number(category), [])
    |> sum
  end

  defp score_pairs([], []), do: 0

  defp score_pairs([], pairs) do
    2 * Enum.max(pairs)
  end

  defp score_pairs(rolls, pairs) do
    [head | tail] = rolls
    if Enum.count(rolls, &(&1 == head)) > 1 do
      found_pairs = Enum.concat([head], pairs)
    else
      found_pairs = pairs
    end
    score_pairs(tail, found_pairs)
  end

  defp match_roll([], _roll_to_match, matches), do: matches

  defp match_roll([head | tail], roll_to_match, matches) when head == roll_to_match do
    match_roll(tail, roll_to_match, Enum.concat(matches, [head]))
  end

  defp match_roll([head | tail], roll_to_match, matches) when head != roll_to_match do
    match_roll(tail, roll_to_match, matches)
  end

  defp sum(rolls), do: _sum(rolls, 0)
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)
  defp _sum([], total), do: total
  defp _sum(number, 0), do: number

  defp category_to_number('Ones'),   do: 1
  defp category_to_number('Twos'),   do: 2
  defp category_to_number('Threes'), do: 3
  defp category_to_number('Fours'),  do: 4
  defp category_to_number('Fives'),  do: 5
  defp category_to_number('Sixes'),  do: 6
end