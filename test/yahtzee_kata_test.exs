defmodule YahtzeeKataTest do
  use ExUnit.Case

  test "scoring Ones through sixes" do
    assert(Yahtzee.score('Ones',   [1,1,2,4,6]) == 2)
    assert(Yahtzee.score('Twos',   [1,2,2,2,4]) == 6)
    assert(Yahtzee.score('Threes', [3,2,3,2,3]) == 9)
    assert(Yahtzee.score('Fours',  [1,4,2,2,4]) == 8)
    assert(Yahtzee.score('Fives',  [1,5,3,5,4]) == 10)
    assert(Yahtzee.score('Sixes',  [1,6,4,5,6]) == 12)
  end
  
  test "Ones through Sixes with no match" do
    assert(Yahtzee.score('Ones',   [2,3,3,4,6]) == 0)
    assert(Yahtzee.score('Twos',   [1,3,3,1,4]) == 0)
    assert(Yahtzee.score('Threes', [1,2,4,4,5]) == 0)
    assert(Yahtzee.score('Fours',  [1,5,2,2,3]) == 0)
    assert(Yahtzee.score('Fives',  [1,2,3,4,4]) == 0)
    assert(Yahtzee.score('Sixes',  [1,3,4,2,4]) == 0)
  end

  test "scoring simple pairs" do
    assert(Yahtzee.score('Pair', [2,1,2,4,5]) == 4)
  end
  
  test 'scoring highest pair only' do
    assert(Yahtzee.score('Pair', [2,1,2,4,4]) == 8)
  end
  
  test 'highest pair more than 2 matches' do
    assert(Yahtzee.score('Pair', [2,4,2,4,4]) == 8)
  end

  test "scoring pairs with no matches" do
    assert(Yahtzee.score('Pair', [1,2,5,3,4]) == 0)
  end

  test "scoring two pair" do
  end

  test "scoring two pair with no match" do
  end

  test "scoring two pair with multiple matches uses highest" do
  end

end