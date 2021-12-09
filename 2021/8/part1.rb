lines = File.readlines("input.txt").map { |x| x.chomp.split(" | ") }

class Digit
  attr_accessor :segments

  def initialize(segments)
    @segments = segments
  end

  def digit
    return 1 if one?
    return 4 if four?
    return 7 if seven?
    return 8 if eight?
    return nil
  end

  private

  def one?
    @segments.length == 2
  end

  def four?
    @segments.length == 4
  end

  def seven?
    @segments.length == 3
  end

  def eight?
    @segments.length == 7
  end
end

class Display
  def initialize(digits)
    @digits = digits.split(" ").map { |x| Digit.new(x) }
  end

  def matching_digits
    @digits.count do |digit|
      [1,4,7,8].include?(digit.digit)
    end
  end
end

displays = lines.map { |signals, expected| Display.new(expected) }

puts displays.map { |x| x.matching_digits }.sum
