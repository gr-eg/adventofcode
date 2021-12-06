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
    if horizontal?
      range = ([from[0], to[0]].min..[from[0], to[0]].max)
      range.to_a.zip(
        range.to_a.fill(from[1])
      )
    else
      range = ([from[1], to[1]].min..[from[1], to[1]].max)
      range.to_a.fill(from[0]).zip(range)
    end
  end

end

wires = lines.map { |x| Wire.new(x[0], x[1]) }
wires = wires.reject(&:diagonal?)

diagram = {}

wires.each do |w|
  w.coordinates.each do |c|
    diagram[c] ||= 0
    diagram[c] += 1
  end
end

puts diagram.values.count { |x| x > 1}
