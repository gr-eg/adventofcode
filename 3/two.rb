# 65  64  63  62  61  60  59  58  57
# 66  37  36  35  34  33  32  31  56
# 67  38  17  16  15  14  13  30  55
# 68  39  18  05  04  03  12  29  54
# 69  40  19  06  01  02  11  28  53
# 70  41  20  07  08  09  10  27  52
# 71  42  21  22  23  24  25  26  51
# 72  43  44  45  46  47  48  49  50
# 73  74  75  76  77  78  79  80  81  


# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23  24  25 

require "byebug"
require "matrix"

class Memory
  def self.run(x_size, y_size)
    x = y = 0
    dx = 0
    dy = -1
    for i in (0..[x_size, y_size].max ** 2)
        if (-x_size/2 < x <= x_size/2) and (-y_size/2 < y <= y_size/2)
            puts "#{x}, #{y}"
        end
        if x == y or (x < 0 and x == -y) or (x > 0 and x == 1-y)
            dx, dy = -dy, dx
          end
        x, y = x+dx, y+dy
    end
  end
end

Memory.run(3,3)
