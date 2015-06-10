class Rover
	attr_reader :x
	attr_reader :y
	attr_reader :direction
	@@cardinals = ["N" , "E" , "S" , "W"]
	
	def initialize(x, y, direction)
		if is_position_valid(x, y, direction)
			@x = x
			@y = y
			@direction = @@cardinals.index(direction)
		end
	end
 	
	def raise_and_rescue(param)
		case param
		when 0
 			raise ArgumentError, "Invalid position parameters!"
 		when 1
 			raise ArgumentError, "Invalid movement command"
 		when 2
 			raise ArgumentError, "Rover will move out of bounds!"
 		end
	end

	def move(x, grid)
		case x
		when 'R'
			@direction = (@direction + 1) % 4
		when 'L'
			@direction = (@direction + 3) % 4
		when 'M'
			translate(grid)
		else
			raise_and_rescue 1
		end
	end
 
 	def is_position_valid(x, y, direction)
 		if (x >= 0 && y >= 0 && ["N", "E", "S", "W"].include?(direction))
 			return true
 		else
 			raise_and_rescue 0
 		end
 	end
	
	def is_move_valid(x, y, grid)
		if x <= grid.grid_x && y <= grid.grid_y && x >= 0 && y >= 0 
			return true
		end
		
		puts "Rover will escape out of bounds on moving in direction #{@@cardinals[@direction]}!"
		raise_and_rescue 2
		return false
	end
 
	def translate(grid)
		case @direction
		when 0
			if(is_move_valid(@x,@y + 1,grid))
				@y += 1
			end
		when 1
			if(is_move_valid(@x + 1,@y,grid))
				@x += 1
			end
		when 2
			if(is_move_valid(@x,@y - 1,grid))
				@y -= 1
			end
		when 3
			if(is_move_valid(@x - 1,@y,grid))
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
	attr_accessor :grid_x
	attr_accessor :grid_y
 
 	def raise_and_rescue
 		raise ArgumentError, "Invalid grid parameters!"
 	end

 	def is_valid(x, y)
 		if (x > 0 && y > 0 )
 			return true
 		end
 		false
 	end

	def initialize (x, y)
		if (!is_valid(x,y))
			raise_and_rescue
		else
			@grid_y = y
			@grid_x = x
		end

 		if __FILE__ == $0
			while true do
				ip = gets.chomp()
				comm = ip.split(" ")
				rover = Rover.new(comm[0].to_i, comm[1].to_i, comm[2])
	 
				command = gets.chomp
				command.each_char do |ch|
					rover.move(ch, self)
				end
				rover.display
			end
		end
	end
end
 

class MarsNavigation
	def initialize()
		ip = gets.chomp()
		comm = ip.split(" ")
		x = comm[0].to_i
		y = comm[1].to_i
 
		grid = Grid.new(x, y)
	end
end
 

if __FILE__ == $0
	nav = MarsNavigation.new
end