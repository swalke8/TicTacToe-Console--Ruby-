require 'rubygems'
require 'swttt-gem'
require 'human'

class Game
  attr_reader :board, :players, :observer

  def initialize(console)
    @console = console
    @board = Board.new
    @observer = GameObserver.new(@board)
    @players = [nil, nil]
  end

  def prompt_for_players
    display_options
    option = @console.gets
    option = option.to_i
    if valid_game_option?(option)
      set_game_option(option)
    else
      prompt_for_players
    end
  end

  def set_players(player1, player2)
    @players[0], @players[1] = player1, player2
    (0...@players.size).each do |player|
      @players[player] = Human.new(@board, @console) if @players[player] == "human"
      @players[player] = MinimaxComputer.new(@board, @observer) if @players[player] == "computer"
    end
  end

  def execute
    while !@observer.game_over?
      @board.print
      @players[0].move
      @board.print
      @players[1].move if !@observer.game_over?
    end
    display_winner
  end

  private

  def display_options
    @console.puts "1. Human vs. Human"
    @console.puts "2. Human vs. Computer"
    @console.puts "3. Computer vs. Computer"
    @console.print "Select a game mode: "
  end

  def valid_game_option?(option)
    option > 0 && option <= 3
  end

  def set_game_option(option)
    if option == 1
      set_players("human", "human")
    elsif option == 2
      set_players("human", "computer")
    else
      set_players("computer", "computer")
    end
  end

  def display_winner
    if @observer.has_winner?
      @console.puts "Player 1 wins!" if @board.player_value == -1
      @console.puts "Player 2 wins!" if @board.player_value == 1
    else
      @console.puts "Cats game!"
    end
  end
end
