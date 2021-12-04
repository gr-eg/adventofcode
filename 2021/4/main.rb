require "byebug"

class Number
  attr_accessor :drawn, :number
  def initialize(number)
    @number = number
    @drawn = false
  end

  def drawn!
    @drawn = true
  end

  def ==(number)
    @number == number
  end

  def inspect
    "#{@number},#{@drawn}"
  end

  def to_i
    @number
  end
end

class Line
  def initialize(numbers)
    @numbers = numbers
  end

  def match_number(number)
    n = @numbers.find { |x| x == number }
    n.drawn! if n
  end

  def winner?
    @numbers.all? { |x| x.drawn }
  end

  def [](i)
    @numbers[i]
  end

  def non_drawn_numbers
    @numbers.select { |x| !x.drawn }.collect(&:number)
  end
end

class Board
  attr_accessor :rows
  def initialize(lines)
    @rows = lines.map do |line|
      Line.new(line.split.map { |n| Number.new(n.to_i) })
    end
  end

  def match_number(number)
    rows.each { |x| x.match_number(number) }
  end

  def winner?
    rows.any?(&:winner?) || columns.any?(&:winner?)
  end

  def score
    rows.flat_map { |x| x.non_drawn_numbers }.sum
  end

  private

  def columns
    (0..4).map do |i|
      Line.new(rows.map { |x| x[i] })
    end
  end
end

class Game
  def initialize(lines)
    @drawn_numbers = lines.shift(1)[0].split(",").map(&:to_i)
    @boards = lines.each_slice(5).map { |x| Board.new(x) }
  end

  def play_part_1
    @drawn_numbers.each do |x|
      @boards.each { |d| d.match_number(x) }
      winner = @boards.find(&:winner?)
      return winner.score * x if winner
    end
  end

  def play_part_2
    @drawn_numbers.each do |x|
      @boards.each { |d| d.match_number(x) }
      return @boards.first.score * x if @boards.one? && @boards.first.winner?
      @boards = @boards.reject(&:winner?)
    end
  end
end

lines = File.readlines("input.txt").map(&:chomp).reject(&:empty?)
game = Game.new(lines)
puts game.play_part_1
puts game.play_part_2
