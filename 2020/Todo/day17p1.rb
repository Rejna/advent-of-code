# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 17 Part 1
# https://adventofcode.com/2020/day/17
# Answer is: ???

input = ['.#.', '..#', '###']
input = [*input.map { |r| r.split('') }]
@input_hash = {}
@input_hash[0] = input

def get_neighbours(x, y, z)
  i = -1
  neighbours = []

  while i < 2
    j = -1
    while j < 2
      k = -1
      while k < 2
        puts "#{k},#{i},#{j}"
        if @input_hash[z + k].nil?
          neighbours << '.'
          k += 1
          next
        end

        if @input_hash[z + k][x + i].nil?
          neighbours << '.'
          k += 1
          next
        end

        if @input_hash[z + k][x + i][y + j].nil?
          neighbours << '.'
          k += 1
          next
        end
        neighbours << @input_hash[z + k][x + i][y + j]
        k += 1
      end
      j += 1
    end
    i += 1
  end
  neighbours.tally
end

puts get_neighbours(0, 0, 0)
