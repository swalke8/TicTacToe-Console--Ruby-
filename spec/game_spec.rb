require 'game'
require 'mock_console'

describe Game do

  before(:each) do
    @console = MockConsole.new
    @game = Game.new(@console)
  end

  it "has a board" do
    @game.board.nil?.should be_false
  end
  
  it "has two players" do
    @game.set_players("human", "computer")
    @game.players[0].is_a?(Human).should be_true
    @game.players[1].is_a?(MinimaxComputer).should be_true
  end

  it "prompts for two players" do
    @console.array_gets = [1,2,3]
    @game.prompt_for_players
    @console.string_puts.should == "1. Human vs. Human2. Human vs. Computer3. Computer vs. ComputerSelect a game mode: "
    @game.players[0].is_a?(Human).should be_true
    @game.players[1].is_a?(Human).should be_true
    @game.prompt_for_players
    @game.players[0].is_a?(Human).should be_true
    @game.players[1].is_a?(MinimaxComputer).should be_true
    @game.prompt_for_players
    @game.players[0].is_a?(MinimaxComputer).should be_true
    @game.players[1].is_a?(MinimaxComputer).should be_true
  end

  it "executes a game" do
    @game.set_players("computer", "computer")
    @game.execute
    @game.observer.has_winner?.should be_false
  end

  it "displays a winner" do
    @game.set_players("human", "human")
    @console.array_gets = [1,1,2,1,1,2,2,2,1,3]
    @game.execute
    @game.observer.has_winner?.should be_true
    @console.string_puts.include?("Player 1 wins!").should be_true
  end
end
