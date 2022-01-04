# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 7 Part 2
# https://adventofcode.com/2017/day/7#part2
# Answer is: 1219

def traverse_tree(node)
  return @nodes[node][0] if @nodes[node][1].empty?

  @nodes[node][1].each do |child|
    @nodes[node][2] += traverse_tree(child)
  end
  @nodes[node][2]
end

def traverse_tree_balance(node)
  child_weights = {}
  @nodes[node][1].each do |child|
    child_weights[child] = @nodes[child][2]
  end

  return true if child_weights.values.uniq.length == 1

  unbalanced = child_weights.max_by { |_k, v| v }[0]
  return unless traverse_tree_balance(unbalanced)

  pp @nodes[unbalanced][0] - (@nodes[unbalanced][2] - child_weights.reject { |_k, v| v == @nodes[unbalanced][2] }.to_a[0][1])
  false
end

input = File.readlines('../1_Input/day07.input').map(&:strip)
# input = File.readlines('../1_Input/day07test.input').map(&:strip)

potential_roots = []
children = []
@nodes = {}

input.each do |row|
  sp = row.split(' -> ')
  node_info = sp[0].split(' ')
  node_name = node_info[0]
  node_weight = node_info[1][1..-2].to_i

  node_children = if sp.length == 2
                    sp[1].split(', ')
                  else
                    []
                  end

  potential_roots << node_name unless node_children.empty?
  children += node_children
  @nodes[node_name] = [node_weight, node_children, node_weight]
end

root = (potential_roots - children)[0]

traverse_tree(root)
traverse_tree_balance(root)
