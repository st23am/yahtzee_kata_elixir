defmodule Yahtzee do

  def score('Pair', rolls) do
    find_pairs(rolls)
    |> pick_highest_pair
    |> sum
  end

  def score('Two pairs', rolls) do
    find_pairs(rolls)
    |> find_two_pair
    |> score_number_of_a_kind(2)
  end

  def score('Three of a kind', rolls) do
    find_number_of_a_kind(rolls, 3)
    |> score_number_of_a_kind(3)
  end

  def score('Four of a kind', rolls) do
    find_number_of_a_kind(rolls, 4)
    |> score_number_of_a_kind(4)
  end

  def score('Full house', rolls) do
    find_number_of_a_kind(rolls, 3)
    |> build_full_house(rolls)
    |> score_full_house
  end

  def score('Small straight', rolls) do
    Enum.sort(rolls)
    |> score_small_straight
  end

  def score('Large straight', rolls) do
    Enum.sort(rolls)
    |> score_large_straight
  end

  def score(category, rolls) do
    match_roll(rolls, category_to_number(category), [])
    |> sum
  end

  defp build_full_house([], rolls), do: 0
  defp build_full_house([x,x,x,x], rolls), do: 0
  defp build_full_house([x,x,x,x,x], rolls), do: 0
  defp build_full_house([x,x,x], rolls), do: Enum.partition(rolls, &(&1 == x))
  
  defp score_full_house(0), do: 0
  defp score_full_house({[x,x,x], [y,y]}), do: sum([x,x,x,y,y])
  defp score_full_house({[x,x,x], [_,_]}), do: 0

  defp find_pairs(rolls) do
    lc number inlist rolls, Enum.count(rolls, &(&1 == number)) > 1, do: number
  end

  defp find_number_of_a_kind(rolls, number) do
    lc value inlist rolls, Enum.count(rolls, &(&1 == value)) >= number, do: value
  end

  defp find_two_pair([_,_]), do: []
  defp find_two_pair([0]),   do: []
  defp find_two_pair(pairs), do: pairs

  defp pick_highest_pair([]),    do: [0]
  defp pick_highest_pair(pairs), do: Enum.max(pairs) * 2

  defp score_number_of_a_kind([]), do: 0
  defp score_number_of_a_kind(pairs, number) do
    Enum.uniq(pairs)
    |> Enum.map(&(&1 * number))
    |> sum
  end

  defp score_small_straight([1,2,3,4,5]), do: 15
  defp score_small_straight([_, _, _, _, _]), do: 0

  defp score_large_straight([2,3,4,5,6]), do: 20
  defp score_large_straight([_, _, _, _, _]), do: 0

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