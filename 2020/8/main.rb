require "byebug"

original_instructions = File.readlines("input.txt").map(&:chomp)
instructions = original_instructions.dup

acc = 0
pos = 0

run = []

modification_index = 0

finished = false

while(!finished) do
  ins = original_instructions[modification_index].split(" ")

  if ["nop", "jmp"].include? ins[0]
    instructions[modification_index] = ins[0] == "nop" ? "jmp #{ins[1]}" : "nop #{ins[1]}"
  end

  while(!run.include?(pos)) do
    instruction = instructions[pos]
    if instruction.nil?
      puts acc

      finished = true
      break
    end

    instruction, val = instruction.split(" ")

    run << pos

    case instruction
    when "acc"
      acc += val.to_i
      pos += 1
    when "jmp"
      pos += val.to_i
    when "nop"
      pos += 1
    end

  end
  pos = 0
  acc = 0
  run = []
  modification_index += 1
  instructions = original_instructions.dup
end
