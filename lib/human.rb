require 'rubygems'
require 'swttt-gem'

class Human

  attr_reader :game_board

  def initialize(board, console)
    @game_board = board
    @console = console
    @player = HumanPlayer.new(@game_board)
  end

  def move
    row, column = get_row_or_column("Row: "), get_row_or_column("Column: ")
    if !@game_board.is_empty_at?(row-1, column-1)
      @console.puts "Invalid move (#{row}, #{column})"
      move
    else
      @player.move(row-1, column-1)
    end
  end

  def get_row_or_column(row_or_column)
    @console.print row_or_column
    prompt_for_row_or_column_value(row_or_column)
  end

private

  def prompt_for_row_or_column_value(row_or_column)
    value = @console.gets.to_i 
    if !valid_row_or_column?(value)
      @console.puts "Invalid #{row_or_column.downcase.delete(": ")} value #{value}"
      get_row_or_column(row_or_column)
    else
      return value
    end
  end

  def valid_row_or_column?(value)
   value > 0 && value <= @game_board.dimension
  end
end
