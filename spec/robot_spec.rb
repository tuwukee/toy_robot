require './lib/toy_robot/robot.rb'

describe 'Robot' do

  let(:robot) { Robot.new }

  describe '#place' do
    context 'wrong input' do
      it { expect(robot.place(1,2,'MADRID')).to eq(Robot::INVALID_DIRECTION) }
      it { expect(robot.place('1','3','SOUTH')).to eq(Robot::INVALID_POSITION) }
      it { expect(robot.place(1.1,2.2,'SOUTH')).to eq(Robot::INVALID_POSITION) }
    end

    context 'call with setted position' do
      it { expect(robot.place(1,1,'SOUTH')).to eq(Robot::DONE) }
      it "result location" do
        robot.place(1,1,'SOUTH')
        expect(robot.position).to eq({x: 1, y: 1})
        expect(robot.direction).to eq('SOUTH')
      end
    end
  end

  describe '#placed?' do
    context 'placed' do
      before { robot.place(1,1,'SOUTH') }
      it { expect(robot.placed?).to be_truthy }
    end

    context 'not placed' do
      it { expect(robot.placed?).to be_falsey }

      it "with position only" do
        robot.position = { x:1, y:1 }
        expect(robot.placed?).to be_falsey
      end

      it "with direction only" do
        robot.direction = 'SOUTH'
        expect(robot.placed?).to be_falsey
      end
    end
  end

  describe '#right' do
    context 'without initial position' do
      it { expect(robot.right).to eq(Robot::PLACE_ERROR) }
    end

    context 'call with setted position' do
      before { robot.place(1,1,'SOUTH') }

      it { expect(robot.right).to eq(Robot::DONE) }
      it "result location" do
        robot.right
        expect(robot.position).to eq({x: 1, y: 1})
        expect(robot.direction).to eq('WEST')
      end
    end
  end

  describe '#left' do
    context 'left without initial position' do
      it { expect(robot.left).to eq(Robot::PLACE_ERROR) }
    end

    context 'with setted position' do
      before { robot.place(1,1,'SOUTH') }

      it { expect(robot.left).to eq(Robot::DONE) }
      it "result location" do
        robot.left
        expect(robot.position).to eq({x: 1, y: 1})
        expect(robot.direction).to eq('EAST')
      end
    end
  end
end
