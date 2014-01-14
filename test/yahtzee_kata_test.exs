defmodule YahtzeeKataTest do
  use ExUnit.Case
  import Yahtzee

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
    assert(Yahtzee.score('Two pairs', [1,2,2,3,3]) == 10)
  end

  test "scoring two pair with no match" do
    assert(Yahtzee.score('Two pairs', [1,2,3,4,5]) == 0)
  end

  test "scoring two pair with with one match" do
    assert(Yahtzee.score('Two pairs', [1,4,3,4,5]) == 0)
  end

  test "scoring two pair with one pair and three of a kind" do
    assert(Yahtzee.score('Two pairs', [5,4,4,4,5]) == 18)
  end

  test "scoring three of a kind" do
    assert(Yahtzee.score('Three of a kind', [5,4,4,4,5]) == 12)
  end

  test "scoring three of a kind with out a match" do
    assert(Yahtzee.score('Three of a kind', [5,4,2,4,5]) == 0)
  end
  
  test "scoring three of a kind with 4 matches" do
    assert(Yahtzee.score('Three of a kind', [4,4,4,4,5]) == 12)
  end

  test "scoring four of a kind" do
    assert(Yahtzee.score('Four of a kind', [4,4,4,4,5]) == 16)
  end

  test "scoring four of a kind with out a match" do
    assert(Yahtzee.score('Four of a kind', [5,4,2,4,5]) == 0)
  end
  
  test "scoring a small straight with a match" do
    assert(Yahtzee.score('Small straight', [1,2,3,4,5]) == 15)
  end
  
  test "scoring a small straight out of order" do
    assert(Yahtzee.score('Small straight', [5,2,1,4,3]) == 15)
  end

  test "scoring a small straight with no match" do
    assert(Yahtzee.score('Small straight', [5,2,3,4,3]) == 0)
  end

  test "scoring a large straight with a match" do
    assert(Yahtzee.score('Large straight', [2,3,4,5,6]) == 20)
  end
  
  test "scoring a large straight out of order" do
    assert(Yahtzee.score('Large straight', [5,6,2,4,3]) == 20)
  end

  test "scoring a large straight with no match" do
    assert(Yahtzee.score('Large straight', [5,2,3,4,3]) == 0)
  end
  
  test "scoring a Full House with a match" do
    assert(Yahtzee.score('Full house', [5,5,1,1,1]) == 13)
  end
  
  test "scoring a Full House with 5 of a kind" do
    assert(Yahtzee.score('Full house', [5,5,5,5,5]) == 0)
  end

  test "scoring a Full House with no match" do
    assert(Yahtzee.score('Full house', [1,1,2,2,3]) == 0)
  end
end
