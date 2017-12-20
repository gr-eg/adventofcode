
class Captcha
  @head_and_tail = ->(x) { [x[0], x[-1]] }

  def initialize(input, offset)
    @chars = input.chomp.chars.map(&:to_i)
    @offset = offset
  end

  def call
    pairs = @chars.each_cons(@offset + 1).map { |x| [x[0], x[-1]] }
    rotated_pairs = @chars.rotate(@offset).each_cons(@offset + 1).map { |x| [x[0], x[-1]] }
    (pairs + rotated_pairs).select { |x, y| x == y }.transpose[0].sum
  end

end

data = File.read('input.txt')
p Captcha.new('1122', 0).call
p Captcha.new(data, data.length / 2).call
