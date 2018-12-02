require "byebug"

class Memory

  
  def initialize(target)
    @target = target
    @counter = 3
    @found = false
    @index = 0
  end
  
  def run
    1000.times do |col|
      sqr = @counter * @counter
      length = @counter + 1
        
      # South -> North
      length.times do |rows_travelled|
        start = sqr + 1
        if start + rows_travelled == @target
          row_dist = (x / 2)
          col_dist = (col + 2)
          puts row_dist + col_dist
          @found = true
          break
        end
      end
      
      # East -> West
      length.times do |rows_travelled|
        start = sqr + 1 + length
        # p rows_travelled
        if start + rows_travelled == @target
          # p sqr
          p length
          p "East -> West"
          row_dist = (col + 2)
          col_dist = (rows_travelled / 2)
          puts row_dist + col_dist
          @found = true
          break
        end
      end
      
      break if @found
      @counter += 2
    end
    @index += 1
  end
end

Memory.new(14).run
