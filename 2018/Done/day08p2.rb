# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 8 Part 2
# https://adventofcode.com/2018/day/8#part2
# Answer is: 25656

def parse_tree(tree, i)
  return if i == tree.length

  puts '-----------------------' if @debug
  puts "parse node | #{i}" if @debug
  child_count = tree[i]
  i += 1
  metadata_count = tree[i]
  i += 1

  node_value = 0
  metadata = []
  children = []

  child_count.times do |k|
    puts "parse child no #{k + 1}" if @debug
    a, value = parse_tree(tree[i..], 0)
    i += a
    children << value
  end

  metadata_count.times do |k|
    puts "parse metadata no #{k + 1}" if @debug
    puts tree[i] if @debug
    metadata << tree[i]
    i += 1
  end
  puts '-----------------------' if @debug

  if child_count.zero?
    node_value = metadata.sum
  else
    puts "#{metadata} #{child_count}" if @debug
    metadata.each do |m|
      next if m > child_count || m.zero?

      node_value += children[m - 1]
    end
  end

  [i, node_value]
end

# inputs = [[[2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2], 66]]
inputs = [File.readlines('day08.input')[0].split(' ').map(&:to_i)]

inputs.each do |input|
  @debug = false

  if input.length == 2
    _i, result = parse_tree(input[0], 0)
    puts "RESULT: #{result} | #{result == input[1] ? 'OK' : 'BAD'}"
  else
    _i, result = parse_tree(input, 0)
    puts result
  end

  puts if @debug
end
