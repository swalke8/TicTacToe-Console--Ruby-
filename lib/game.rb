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
    option = @console.gets.to_i
    validate_option(option)
  end

  def execute
    @board.print
    while !@observer.game_over?
      @players.each { |player| next_move(player) }
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

  def validate_option(option)
    if valid_game_option?(option)
      set_game_option(option)
    else
      prompt_for_players
    end
  end

  def valid_game_option?(option)
    option > 0 && option <= 3
  end

  def set_game_option(option)
    if option == 1
      player1, player2 = "human", "human"
    elsif option == 2
      player1, player2 = "human", "computer"
    else
      player1, player2 = "computer", "computer"
    end
    set_players(player1, player2)
  end

  def set_players(player1, player2)
    @players[0], @players[1] = player1, player2
    (0...@players.size).each do |player|
      @players[player] = Human.new(@board, @console) if @players[player] == "human"
      @players[player] = MinimaxComputer.new(@board, @observer) if @players[player] == "computer"
    end
  end

  def next_move(player)
    if !@observer.game_over?
      player.move
      @board.print
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
