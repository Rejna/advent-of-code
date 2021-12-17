# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 14 Part 1
# https://adventofcode.com/2020/day/14
# Answer is: 14553106347726

# input = ['mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X', 'mem[8] = 11', 'mem[7] = 101', 'mem[8] = 0']
input = File.readlines('../1 Input/day14.input').map(&:strip)
@mask = ''
mem = {}

def apply_mask(input)
  input_bin = input.to_s(2).rjust(36, '0').split('')
  mask = @mask.split('')
  i = 0

  while i < 36
    input_bin[i] = mask[i] unless mask[i] == 'X'
    i += 1
  end
  input_bin.join.to_i(2)
end

input.each do |line|
  line = line.split(' = ')

  if line[0] == 'mask'
    @mask = line[1]
  else
    address = line[0].gsub!('mem[', '').gsub!(']', '').to_i
    data = line[1].to_i
    mem[address] = apply_mask(data)
    # puts "mem[#{address}] = #{mem[address]}"
  end
end

puts mem.values.sum
