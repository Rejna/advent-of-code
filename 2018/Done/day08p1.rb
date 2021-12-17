# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 8 Part 1
# https://adventofcode.com/2018/day/8
# Answer is: 49602

def parse_tree(tree, i)
  return if i == tree.length

  puts '-----------------------' if @debug
  puts "parse node | #{i}" if @debug
  child_count = tree[i]
  i += 1
  metadata_count = tree[i]
  i += 1

  child_count.times do |k|
    puts "parse child no #{k + 1}" if @debug
    i += parse_tree(tree[i..], 0)
  end

  metadata_count.times do |k|
    puts "parse metadata no #{k + 1}" if @debug
    puts tree[i] if @debug
    @metadata_sum += tree[i]
    i += 1
  end
  puts '-----------------------' if @debug

  i
end

# inputs = [[[2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2], 138]]
inputs = [File.readlines('day08.input')[0].split(' ').map(&:to_i)]

inputs.each do |input|
  @debug = true
  @metadata_sum = 0

  if input.length == 2
    parse_tree(input[0], 0)
    puts "RESULT: #{@metadata_sum} | #{@metadata_sum == input[1] ? 'OK' : 'BAD'}"
  else
    parse_tree(input, 0)
    puts @metadata_sum
  end

  puts if @debug
end
