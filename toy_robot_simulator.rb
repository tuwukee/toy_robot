class ToyRobotSimulator
  INVALID_INPUT = "Oops, Wrong input format.".freeze

  def process(command)
    return INVALID_INPUT if command.strip.empty?

    @command, @args = command.split.map(&:downcase)
    self.send(@command)
  end

  private

  def left
  end

  def right
  end

  def move
  end

  def place
  end

  def report
    "Output: "
  end

  def method_missing(method)
    return INVALID_INPUT
  end
end