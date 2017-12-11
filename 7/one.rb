require 'pp'
require 'byebug'

class Program
  attr_accessor :name, :weight, :nodes

  def initialize(n, w, programs)
    @name = n
    @weight = w.to_i
    @nodes = programs
  end

  def total_weight
    @weight + node_weights.sum
  end

  def node_weights
    @nodes.values.map(&:total_weight)
  end

  def balanced?
    node_weights.uniq.count == 1
  end

  def unbalanced_by
    node_weights.max - node_weights.min
  end
end

class Parser
  RGX = %r{
    (?<name>\S+)
    \s\((?<weight>\d+)\)(?:\s->\s)?(?<programs>.+)?
  }x

  def initialize
    @input = File.readlines('input.txt').map(&:chomp)
  end

  def find_unbalanced_node(nodes)
    unbalanced = nodes.find { |k,v| !v.balanced? }
    unbalanced ? unbalanced[1] : false
  end

  def find_deepest_unbalanced_node(program)
    next_unbalanced_node = find_unbalanced_node(program.nodes)
    return program unless next_unbalanced_node
    find_deepest_unbalanced_node(next_unbalanced_node)
  end

  def run
    tree = {}
    @input.each do |line|
      match = RGX.match(line)
      tree[match[:name]] = Program.new(match[:name], match[:weight], (match[:programs] || '').split(', '))
    end

    tree.values.each do |program|
      branch = tree.select {|k,v| program.nodes.include? k }
      program.nodes = branch
      tree.reject! {|k, v| branch.include? k }
    end
    _k, base = tree.first

    deepest_unbalanced_node = find_deepest_unbalanced_node(base)

    diff = deepest_unbalanced_node.nodes.values.map(&:total_weight).minmax.inject(:-).abs
    total_node_weight = Hash[deepest_unbalanced_node.nodes.map{ |k,v| [k, v.total_weight] }]
    odd_value = total_node_weight.values.detect{ |e| total_node_weight.values.count(e) == 1 }

    odd_weight = total_node_weight.key(odd_value)
    pp deepest_unbalanced_node.nodes[odd_weight].weight - diff
  end
end

Parser.new.run
