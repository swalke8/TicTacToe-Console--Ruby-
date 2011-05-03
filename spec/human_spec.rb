require 'human'
require 'mock_console'
describe Human do
  before(:each) do
    @board = Board.new
    @console = MockConsole.new
    @player = Human.new(@board, @console)
    @console.array_gets = [1]
  end

  it "has a board" do
    @player.game_board.nil?.should be_false
  end

  context "Row" do
    before do
      @player.prompt("Row: ")
    end

    it "prompts for a row" do
      @console.string_puts.should == "Row: "
    end

    it "gets a row value" do
      @console.array_gets.should == []
    end

    it "validates a row value" do
      @console.array_gets = [4,"a",0,1]
      @player.prompt("Row: ")
      @console.array_gets.should == []
    end
  end

  context "Column" do
    before do
      @player.prompt("Column: ")
    end

    it "prompts for a column" do
      @console.string_puts.should == "Column: "
    end

    it "gets a column value" do
      @console.array_gets.should == []
    end

    it "validates a column value" do
      @console.array_gets = [-1,'h',2]
      @player.prompt("Column: ")
      @console.array_gets.should == []
    end
  end

  it "gets a move" do
    @console.array_gets = [1,1]
    @player.move
    @board.number_of_moves_made.should == 1
    @console.array_gets.should == []
  end

  it "validates a move" do
    @console.array_gets = [-1,1,1,1,1,2,2,3,3]
    @player.move
    @player.move
    @board.number_of_moves_made.should == 2
    @console.array_gets.should == [3,3]
  end
end
