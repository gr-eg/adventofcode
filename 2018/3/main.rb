#!/usr/bin/env ruby
require 'byebug'

class Claim
  attr_reader :id, :left, :top, :width, :height
  def initialize(id, left, top, width, height)
    @id = id
    @left = left.to_i
    @top = top.to_i
    @width = width.to_i - 1
    @height = height.to_i - 1
  end
end

CLAIM_REGEXP = /#(?<id>\d+)\s@\s(?<left>\d+),(?<top>\d+):\s(?<width>\d+)x(?<height>\d+)/
fabric = Array.new(0, [])

lines = File.readlines('input.txt').map! do |x|
  Claim.new(*x.chomp.match(CLAIM_REGEXP).captures)
end

lines.each do |line|
  (line.top..(line.top + line.height)).each do |height|
    fabric[height] ||= []
    (line.left..(line.left + line.width)).each do |width|
      fabric[height][width] = fabric[height][width] ? 'x' : line.id
    end
  end
end

puts "Part 1: #{fabric.flatten.count('x')}"
