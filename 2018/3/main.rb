#!/usr/bin/env ruby
require 'byebug'

class Claim
  attr_reader :id, :left, :top, :width, :height
  attr_accessor :overlapped
  def initialize(id, left, top, width, height)
    @id = id
    @left = left.to_i
    @top = top.to_i
    @width = width.to_i - 1
    @height = height.to_i - 1
    @overlapped = false
  end
end

CLAIM_REGEXP = /#(?<id>\d+)\s@\s(?<left>\d+),(?<top>\d+):\s(?<width>\d+)x(?<height>\d+)/
fabric = Array.new(0, [])
claims = {}

File.readlines('input.txt').map! do |x|
  claim = Claim.new(*x.chomp.match(CLAIM_REGEXP).captures)
  claims[claim.id] = claim
end

claims.each do |_id, claim|
  (claim.top..(claim.top + claim.height)).each do |height|
    fabric[height] ||= []
    (claim.left..(claim.left + claim.width)).each do |width|
      if fabric[height][width]
        claim.overlapped = true
        claims[fabric[height][width]]&.overlapped = true
        fabric[height][width] = 'x'
      else
        fabric[height][width] = claim.id
      end
    end
  end
end

puts "Part 1: #{fabric.flatten.count('x')}"
puts "Part 2: #{claims.find { |_key, hash| !hash.overlapped }[1].id}"
