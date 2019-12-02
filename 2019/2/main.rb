class Computer
  HALT = "halt".freeze

  def initialize(program)
    @original_program = File.read(program).split(",").map(&:to_i)
    @memory = @original_program.dup
    @pointer = 0
  end

  def run(noun, verb)
    reset!
    @memory[1] = noun
    @memory[2] = verb
    loop do
      res = run_instruction
      break if res == HALT
      @memory[out] = res
      @pointer += 4
    end
    @memory[0]
  end

  private

  def run_instruction
    case instruction
    when 1
      @memory[p1] + @memory[p2]
    when 2
      @memory[p1] * @memory[p2]
    when 99
      HALT
    end
  end

  def instruction
    @memory[@pointer]
  end

  def p1
    @memory[@pointer + 1]
  end

  def p2
    @memory[@pointer + 2]
  end

  def out
    @memory[@pointer + 3]
  end

  def reset!
    @memory = @original_program.dup
    @pointer = 0
  end
end

comp = Computer.new('input.txt')

puts "Part 1: #{comp.run(12, 2)}"

[*(0..99)].product([*(0..99)]).each do |x|
  res = comp.run(x[0], x[1])
  if res == 19690720
    puts "Part 2: #{100 * x[0] + x[1]}"
    break
  end
end
