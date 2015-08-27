require './tabletop.rb'
require './robot.rb'

class ToyRobotSimulator
  INVALID_INPUT = "Oops, Wrong input format.".freeze
  PLACE_THE_ROBOT = "Place the robot to the table, please".freeze
  OUT_OF_THE_TABLE = "Can't move the robot outside the table".freeze
  WRONG_POSITION = "Wrong position, please check the tabletop dimension".freeze

  def initialize(robot, table)
    @robot = robot
    @table = table
  end

  def process(command)
    return INVALID_INPUT if command.strip.empty?

    @command, @args = command.split.map(&:downcase)
    self.send(@command)
  end

  private

  def left
    @robot.left
  end

  def right
    @robot.right
  end

  def move
    return PLACE_THE_ROBOT unless @robot.placed?
    next_position = @robot.next_position
    if @table.inside_borders?(next_position[:x], next_position[:y])
      @robot.move(next_position)
    else
      OUT_OF_THE_TABLE
    end
  end

  def place
    args = @args.split(/,/)
    return INVALID_INPUT unless args.size == 3 && valid_position?(args[0]) && valid_position?(args[1]) && @robot.valid_direction?(args[2])
    return WRONG_POSITION unless @table.inside_borders?(args[0].to_i, args[1].to_i)
    @robot.place(args[0].to_i, args[1].to_i, args[2].upcase)
  end

  def report
    @robot.report
  end

  def method_missing(method)
    return INVALID_INPUT
  end

  private

  def valid_position?(pos)
    pos.to_i.to_s == pos
  end
end