class Debugger
  
  def initialize(input)
    @input = input
  end
  
  def redistribute
    max_bank = @input.find_index(@input.max)
    blocks_to_distribute = @input[max_bank]
    @input[max_bank] = 0
    
    i = max_bank + 1
    while blocks_to_distribute > 0
      @input[i % @input.length] += 1
      blocks_to_distribute -= 1
      i += 1
    end
  end

  def run
    states = []
    counter = 1
    while true
      redistribute
      
      break if states.include?(@input)
      states << @input.dup
      counter += 1
    end

    p counter
    
    counter = 1
    last = states.last.dup
    states = []
    
    while true
      redistribute
      
      break if states.include?(last)
      states << @input.dup
      counter += 1
    end
    p counter
  end

end
  

Debugger.new(File.read("input.txt").split.map(&:to_i)).run