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
    row, column = prompt("Row: "), prompt("Column: ")
    if !@game_board.is_empty_at?(row-1, column-1)
      @console.puts "Invalid move (#{row}, #{column})"
      move
    else
      @player.move(row-1, column-1)
    end
  end

  def prompt(row_or_column)
    @console.print row_or_column
    get_row_or_column_value(row_or_column)
  end

private

  def get_row_or_column_value(row_or_column)
    value = -1
    value = @console.gets.to_i 
    if !valid_row_or_column?(value)
      @console.puts "Invalid #{row_or_column.downcase.delete(": ")} value #{value}"
      prompt(row_or_column)
    else
      return value
    end
  end

  def valid_row_or_column?(value)
   value > 0 && value <= @game_board.dimension
  end
end
