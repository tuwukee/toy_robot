class Tabletop
  def initialize(width, height)
    @width, @height = width, height
  end

  def inside_borders?(x, y)
    x.between?(0, @width) && y.between?(0, @height)
  end
end