require 'game'
require 'real_console'

@console = RealConsole.new
@game = Game.new(@console)

@game.prompt_for_players

@game.execute
