require 'human_player'

class MockConsole

	attr_accessor :array_gets, :string_puts

	def initialize
		@array_gets
		@string_puts = String.new
	end

	def print(string)
		@string_puts << string
	end

	def puts(string)
		@string_puts << string
	end

	def putc(string)
		@string_puts << string
	end

	def gets
    @array_gets.shift
	end
end
