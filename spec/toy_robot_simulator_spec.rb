require 'spec_helper'

describe 'ToyRobotSimulator' do

  let(:robot) { Robot.new }
  let(:table) { Tabletop.new(4,4) }
  let(:simulator) { ToyRobotSimulator.new(robot, table) }

  describe '#process' do

    context "wrong input" do
      it { expect(simulator.process('')).to eq(ToyRobotSimulator::INVALID_INPUT) }
      it { expect(simulator.process(' ')).to eq(ToyRobotSimulator::INVALID_INPUT) }
      it { expect(simulator.process('AAAA')).to eq(ToyRobotSimulator::INVALID_INPUT) }
      it { expect(simulator.process('PLACE 111')).to eq(ToyRobotSimulator::INVALID_INPUT) }
      it { expect(simulator.process('MOVE')).to eq(ToyRobotSimulator::PLACE_THE_ROBOT) }
      it { expect(simulator.process('PLACE 1,2,NOWHERE')).to eq(ToyRobotSimulator::INVALID_INPUT) }
      it { expect(simulator.process('PLACE 1,2222,NORTH')).to eq(ToyRobotSimulator::WRONG_POSITION) }
    end

    context "place" do
      it 'places the robot' do
        expect(simulator.process('PLACE 1,1,NORTH')).to eq(Robot::DONE)
        expect(robot.position).to eq({x: 1, y: 1})
        expect(robot.direction).to eq('NORTH')
      end
    end

    context "after the robot has been placed" do
      before { simulator.process('PLACE 1,1,NORTH') }

      context "left" do
        it 'rotates the robot to left' do
          expect(simulator.process('LEFT')).to eq(Robot::DONE)
          expect(robot.position).to eq({x: 1, y: 1})
          expect(robot.direction).to eq('WEST')
        end
      end

      context "right" do
        it 'rotates the robot to right' do
          expect(simulator.process('RIGHT')).to eq(Robot::DONE)
          expect(robot.position).to eq({x: 1, y: 1})
          expect(robot.direction).to eq('EAST')
        end
      end

      context "move" do
        it 'moves the robot' do
          expect(simulator.process('MOVE')).to eq(Robot::DONE)
          expect(robot.position).to eq({x: 1, y: 2})
          expect(robot.direction).to eq('NORTH')
        end

        it "doesn't move the robot outside the tabletop" do
          10.times { simulator.process('MOVE') }
          expect(robot.position).to eq({x: 1, y: 4})
        end
      end
    end
  end
end