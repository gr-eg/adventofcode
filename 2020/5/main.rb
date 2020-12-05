require "benchmark"

seat_ids = []
ms = Benchmark.measure do
  seats = File.read_lines("input.txt").map { |x| x.split("") }

  def median(a,b)
    ((a+b)/2.0).round
  end

  seats.each do |seat|
    row_start = 0
    row_end = 127
    col_start = 0
    col_end = 7
    seat.each do |x|
      case x
      when "F"
        row_end = median(row_start, row_end)
      when "B"
        row_start = median(row_start, row_end)
      when "L"
        col_end = median(col_start, col_end)
      when "R"
        col_start = median(col_start, col_end)
      end
    end
    seat_ids << row_start * 8 + col_start
  end
end

puts seat_ids.max
seat_ids.sort!
puts (seat_ids[0]..seat_ids[-1]).to_a - seat_ids
puts ms.real * 1000
