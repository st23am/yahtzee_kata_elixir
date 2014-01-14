defmodule Yahtzee do

  def score('Pair', rolls) do
    find_pairs(rolls)
    |> pick_highest_pair
    |> sum
  end

  def score('Two pairs', rolls) do
    find_pairs(rolls)
    |> find_two_pair
    |> score_two_pairs
    |> sum
  end

  def score('Three of a kind', rolls) do
    find_three_of_a_kind(rolls)
    |> score_pairs
  end

  def score(category, rolls) do
    match_roll(rolls, category_to_number(category), [])
    |> sum
  end

  defp find_pairs(rolls) do
    lc number inlist rolls, Enum.count(rolls, &(&1 == number)) > 1, do: number
  end

  defp find_two_pair([_,_]), do: []
  defp find_two_pair([0]),   do: []
  defp find_two_pair(pairs), do: pairs

  defp find_three_of_a_kind(rolls) do
    lc number inlist rolls, Enum.count(rolls, &(&1 == number)) == 3, do: number
  end
  
  defp pick_highest_pair([]),    do: [0]
  defp pick_highest_pair(pairs), do: Enum.max(pairs) * 2
  
  defp score_pairs([]), do: 0
  defp score_pairs([_]), do: 0
  defp score_pairs(pairs) do
    sum(pairs)
  end

  defp score_two_pairs([]),   do: 0
  defp score_two_pairs(pairs) do
    Enum.uniq(pairs)
    |> Enum.map(&(&1 * 2))
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