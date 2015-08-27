require './toy_robot/toy_robot_simulator.rb'

robot = Robot.new
table = Tabletop.new(4,4)
simulator = ToyRobotSimulator.new(robot, table)

while command = gets
  puts simulator.process(command)
end