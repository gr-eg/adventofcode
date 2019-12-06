require "benchmark"
require "byebug"

class Computer
  HALT = "halt".freeze

  def initialize(program)
    @original_program = File.read(program).split(",").map(&:to_i)
    @memory = @original_program.dup
    @pointer = 0
  end

  def run
    reset!
    loop do
      res = run_instruction
      break if res == HALT
    end
    @memory[0]
  end

  private

  def run_instruction
    case instruction
    when 1
      set_val(3, p1 + p2)
      @pointer += 4
    when 2
      set_val(3, p1 * p2)
      @pointer += 4
    when 3
      print "Enter ID: "
      set_val(1, gets.to_i)
      @pointer += 2
    when 4
      puts p1
      @pointer += 2
    when 5
      if p1 != 0
        @pointer = p2
      else
        @pointer += 3
      end
    when 6
      if p1 == 0
        @pointer = p2
      else
        @pointer += 3
      end
    when 7
      val = p1 < p2 ? 1 : 0
      set_val(3, val)
      @pointer += 4
    when 8
      val = p1 == p2 ? 1 : 0
      set_val(3, val)
      @pointer += 4
    when 99
      HALT
    end
  end

  def instruction
    @memory[@pointer] % 100
  end

  def p1
    if (@memory[@pointer] / 100 % 10).zero?
      @memory[@memory[@pointer + 1]]
    else
      @memory[@pointer + 1]
    end
  end

  def p2
    if (@memory[@pointer] / 1000 % 10).zero?
      @memory[@memory[@pointer + 2]]
    else
      @memory[@pointer + 2]
    end
  end

  def set_val(offset, val)
    @memory[@memory[@pointer + offset]] = val
  end

  def reset!
    @memory = @original_program.dup
    @pointer = 0
  end
end

comp = Computer.new('input.txt')
comp.run
