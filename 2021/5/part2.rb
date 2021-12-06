lines = File.readlines("input.txt").map do |line|
  line.chomp.split(" -> ").map do |w|
    w.split(',').map(&:to_i)
  end
end

class Wire
  attr_accessor :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def vertical?
    @from[0] == @to[0]
  end

  def horizontal?
    @from[1] == @to[1]
  end

  def diagonal?
    !horizontal? && !vertical?
  end

  def coordinates
    return horizontal_coords if horizontal?
    return vertical_coords if vertical?
    return diagonal_coords
  end

  private

  def down_and_to_the_right
    to[0] > from[0] && to[1] > from[1]
  end

  def up_and_to_the_right
    from[0] > to[0] && from[1] > to[1]
  end

  def horizontal_coords
    range = ([from[0], to[0]].min..[from[0], to[0]].max)
    range.zip(
      range.to_a.fill(from[1])
    )
  end

  def vertical_coords
    range = ([from[1], to[1]].min..[from[1], to[1]].max)
    range.to_a.fill(from[0]).zip(range)
  end

  def diagonal_coords
    if(down_and_to_the_right || up_and_to_the_right)
      r1 = ([from[0], to[0]].min)..([from[0], to[0]].max)
      r2 = ([from[1], to[1]].min)..([from[1], to[1]].max)
    else
      r1 = [from[0], to[0]].min..[from[0], to[0]].max
      r2 = [from[1], to[1]].max.downto([from[1], to[1]].min)
    end
    r1.zip(r2)
  end
end

wires = lines.map { |x| Wire.new(x[0], x[1]) }
diagram = {}

wires.each do |w|
  w.coordinates.each do |c|
    diagram[c] ||= 0
    diagram[c] += 1
  end
end

puts diagram.values.count { |x| x > 1 }
