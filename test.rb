require "minitest/autorun"
require "./mars_rover.rb"

class TestRover < Minitest::Test
	
	def setup
		@rover = Rover.new(0, 0, "N")
		@grid = Grid.new(5, 5)
	end

	def test_grid_limits
		assert_equal 5, Grid.new(5, 5).grid_x
		assert_equal 5, @grid.grid_x
		assert_equal 5, @grid.grid_y

		assert_raises (ArgumentError) { Grid.new(-3,-3) }
		assert_raises (ArgumentError) { Grid.new(4,-2) }
		assert_raises (ArgumentError) { Grid.new(0,6) }
	end

	def test_direction 
		@rover.move('L',@grid)
		assert_equal 3, @rover.direction
		
		@rover.move('R',@grid)
		assert_equal 0, @rover.direction
		
		#moving forward should not change directions
		@rover.move('M',@grid)
		assert_equal 0, @rover.direction

		@rover.move('R',@grid)
		assert_equal 1, @rover.direction

		@rover.move('R',@grid)
		assert_equal 2, @rover.direction

		@rover.move('M',@grid)
		assert_equal 2, @rover.direction

		@rover.move('L',@grid)
		assert_equal 1, @rover.direction

		@rover.move('L',@grid)
		assert_equal 0, @rover.direction
	end

	def test_translation
		@rover.translate(@grid)
		assert_equal 0, @rover.x

		@rover.translate(@grid)
		assert_equal 2, @rover.y

		#off limit transalations
		assert_raises (ArgumentError) {@rover.translate(Grid.new(2,2)) }
		assert_equal 2, @rover.y

		@rover.translate(@grid) 
		assert_equal 0, @rover.x

		@rover.move('R',@grid)
		@rover.translate(@grid)
		assert_equal 1, @rover.x
		#rover now faces East

		@rover.translate(@grid)
		assert_equal 2, @rover.x

		@rover.move('R',Grid.new(2,2))
		assert_equal 2, @rover.x
		#rover now faces South
		@rover.translate(@grid)
		assert_equal 2, @rover.y

		@rover.translate(@grid)
		assert_equal 1, @rover.y

		@rover.move('R',@grid)
		#rover now faces West
		@rover.translate(@grid)
		assert_equal 1, @rover.x
	end

	def test_validity
		assert_equal true, @rover.is_move_valid(4,4,@grid)
		assert_raises (ArgumentError) { @rover.is_move_valid(6,6,@grid)}
		assert_raises (ArgumentError) { @rover.is_move_valid(3,6,@grid)}
		assert_raises (ArgumentError) { @rover.is_move_valid(6,3,@grid)}
	end

end
