require 'rubygems'
require 'swttt-gem'
require 'game'
require 'real_console'
require 'human'

@console = RealConsole.new
@game = Game.new(@console)

@game.prompt_for_players

@game.execute
