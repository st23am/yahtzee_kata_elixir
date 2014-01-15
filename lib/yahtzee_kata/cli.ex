defmodule YahtzeeKata.CLI do

  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case parse do
      { [ help: true], _,             _ } -> :help
      { _, [ category, rolls ],  _      } -> { category, rolls }
      _                                   -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: "Yahtzee" <category> <rolls>
    example: Yahtzee "Pairs" 12332
    """
    System.halt(0)
  end

  def process({category , rolls}) do
    parsed_rolls = Enum.map(String.codepoints(rolls), &(Enum.at(Kernel.tuple_to_list(Integer.parse(&1)), 0)))
    IO.puts Yahtzee.score(String.to_char_list!(category), parsed_rolls)
  end
end
