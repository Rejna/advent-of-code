# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 3 Part 2
# https://adventofcode.com/2021/day/3#part2
# Answer is: 4550283

def min(a, b)
  a if a == b
  a < b ? a : b
end

def max(a, b)
  b if a == b
  a > b ? a : b
end

# input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]
input = File.readlines('../1 Input/day03.input').map(&:strip)

col_id = 0
temp_most = [*input]
temp_least = [*input]
all_bits = temp_most[0].length
result = 1

while col_id < all_bits
  col = []
  temp_most.each do |bin|
    col << bin[col_id]
  end
  tally = col.tally
  tally0 = tally['0'] || 0
  tally1 = tally['1'] || 0
  most_common = max(tally0, tally1) == tally1 ? '1' : '0'

  temp = []
  temp_most.each do |t|
    temp << t if t[col_id] == most_common
  end

  if temp_most.length == 1
    # puts "most oxygen #{temp_most[0].to_i(2)}"
    result *= temp_most[0].to_i(2)
    temp_most = []
    break
  elsif temp.length == 1
    # puts "temp oxygen #{temp[0].to_i(2)}"
    result *= temp[0].to_i(2)
    break
  else
    # puts "#{col_id} #{temp.join(' ')}"
    temp_most = [*temp]
    col_id += 1
  end
end

col_id = 0
while col_id < all_bits
  col = []
  temp_least.each do |bin|
    col << bin[col_id]
  end
  tally = col.tally
  tally0 = tally['0'] || 0
  tally1 = tally['1'] || 0
  least_common = min(tally0, tally1) == tally0 ? '0' : '1'

  temp = []
  temp_least.each do |t|
    temp << t if t[col_id] == least_common
  end

  if temp_least.length == 1
    # puts "least co2 #{temp_least[0].to_i(2)}"
    result *= temp_least[0].to_i(2)
    temp_least = []
    break
  elsif temp.length == 1
    # puts "temp co2 #{temp[0].to_i(2)}"
    result *= temp[0].to_i(2)
    break
  else
    # puts "#{col_id} #{temp.join(' ')}"
    temp_least = [*temp]
    col_id += 1
  end
end

puts result
