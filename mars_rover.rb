class Rover
	@x = 0
	@y = 0
	@direction = 0
	@@cardinals = ["N" , "E" , "S" , "W"]
	
	def initialize(x,y,direction)
		@x = x
		@y = y
		@direction = direction
		@@cardinals = ["N" , "E" , "S" , "W"]
	end

	def x
		@x
	end

	def y
		@y
	end
	
	def move(x, grid)
		case x
		when 'R'
			@direction = (@direction + 1) % 4
		when 'L'
			@direction = (@direction + 3) % 4
		when 'M'
			translate(grid)
		end

		return @@cardinals[@direction]
	end


	def is_valid(x, y, grid)
		if x <= grid.grid_x && y <= grid.grid_y && x >= 0 && y >= 0
			return true
		end
		return false
	end

	def translate(grid)
		case @direction
		when 0
			if(is_valid(@x,@y + 1,grid))
				@y += 1
			end
		when 1
			if(is_valid(@x + 1,@y,grid))
				@x += 1
			end
		when 2
			if(is_valid(@x,@y - 1,grid))
				@y -= 1
			end
		when 3
			if(is_valid(@x - 1,@y,grid))
				@x -= 1
			end
		else
			puts "Invalid"
		end
	end

	def display
		puts "#{@x} #{@y} #{@@cardinals[@direction]}"
	end	
end

class Grid
	@grid_x = 0
	@grid_y = 0

	def initialize (x, y)
		@grid_x = x
		@grid_y = y
	end

	def grid_x
		@grid_x
	end

	def grid_y
		@grid_y
	end
end



