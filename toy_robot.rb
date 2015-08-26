require './toy_robot_simulator.rb'

simulator = ToyRobotSimulator.new

while command = gets
  puts simulator.process(command)
end