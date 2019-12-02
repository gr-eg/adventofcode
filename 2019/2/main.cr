class Computer
  @original_program : Array(Int32)
  @memory : Array(Int32)

  def initialize(program : String)
    @original_program = File.read(program).split(",").map { |i| i.to_i }
    @memory = @original_program.dup
    @pointer = 0
  end

  def run(noun, verb)
    reset!
    @memory[1] = noun
    @memory[2] = verb
    loop do
      res = run_instruction
      break if res == -1
      @memory[store] = res
      @pointer += 4
    end
    @memory[0]
  end


  private def run_instruction : Int32
    case instruction
    when 1
      @memory[p1] + @memory[p2]
    when 2
      @memory[p1] * @memory[p2]
    when 99
      -1
    else
      -1
    end
  end

  private def instruction
    @memory[@pointer]
  end

  private def p1
    @memory[@pointer + 1]
  end

  private def p2
    @memory[@pointer + 2]
  end

  private def store : Int32
    @memory[@pointer + 3]
  end

  private def reset!
    @memory = @original_program.dup
    @pointer = 0
  end
end

comp = Computer.new("input.txt")

puts "Part 1: #{comp.run(12, 2)}"

(0..99).to_a.product((0..99).to_a).each do |x|
  res = comp.run(x[0], x[1])
  if res == 19690720
    puts "Part 2: #{100 * x[0] + x[1]}"
    break
  end
end
