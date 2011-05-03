class RealConsole

	def gets
		$stdin.gets
	end

	def print(string)
		$stdout.print string
	end

	def puts(string)
		$stdout.puts string
	end

	def putc(string)
		$stdout.putc string
	end
end
