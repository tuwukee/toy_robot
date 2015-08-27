class Robot
  attr_accessor :direction, :position
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST']
  PLACE_ERROR = "Oops, the robot has not been placed".freeze
  INVALID_DIRECTION = "The direction must be NORTH, EAST, SOUTH or WEST".freeze
  DONE = "Done".freeze

  def place(x, y, direction)
    return INVALID_DIRECTION unless self.valid_direction?(direction)
    @position = {x: x, y: y}
    @direction = direction
    DONE
  end

  def placed?
    @position && @direction
  end

  def report
    if self.placed?
      "Output: #{@position[:x]},#{@position[:y]},#{@direction}"
    else
      PLACE_ERROR
    end
  end

  def left
    return PLACE_ERROR unless self.placed?
    @direction = DIRECTIONS[DIRECTIONS.index(@direction) - 1]
    DONE
  end

  def right
    return PLACE_ERROR unless self.placed?
    next_ind = DIRECTIONS.index(@direction) + 1
    @direction = DIRECTIONS[next_ind > 3 ? 0 : next_ind]
    DONE
  end

  def next_position
    return false unless self.placed?
    case @direction
      when 'NORTH'
        { x: @position[:x], y: @position[:y] + 1 }
      when 'EAST'
        { x: @position[:x] + 1, y: @position[:y] }
      when 'SOUTH'
        { x: @position[:x], y: @position[:y] - 1 }
      when 'WEST'
        { x: @position[:x] - 1, y: @position[:y] }
    end
  end

  def move(position)
    @position = position
    DONE
  end

  def valid_direction?(direction)
    DIRECTIONS.include?(direction.upcase)
  end
end