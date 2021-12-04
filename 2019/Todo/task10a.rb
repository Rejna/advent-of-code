# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 10 Part 1
# https://adventofcode.com/2019/day/10
# Answer is: ???

input = ['.#..#', '.....', '#####', '....#', '...##']

i = 0
j = 1
jumps = []
size = input[0].length

while i < size && j < size
  jumps << [i, j]
  jumps << [-1 * i, j]
  jumps << [i, -1 * j]
  jumps << [-1 * i, -1 * j]

  if i != j
    jumps << [j, i]
    jumps << [-1 * j, i]
    jumps << [j, -1 * i]
    jumps << [-1 * j, -1 * i]
  end

  if i <= j
    i += 1
  else
    j += 1
  end
end

i = 0
best_i = 0
best_j = 0
best = 0

jumps = jumps.uniq

while i < size
  j = 0
  while j < size
    if input[i][j] == '#'
      ast = 0
      jumps.each do |jump|
        times = 1
        loop do
          jump_i = i + times * jump[0]
          jump_j = j + times * jump[1]
          break unless jump_i >= 0 && jump_j >= 0 && jump_j < size && jump_i < size

          jum = (input[jump_i][jump_j] || 'x')
          puts "#{i} #{j} | #{times} | #{jump[0]} #{jump[1]} | #{jum} | #{jump_i} #{jump_j}"
          case jum
          when '.'
            times += 1
          when '#'
            ast += 1
            break
          else
            break
          end
        end
      end

      if ast > best
        best = ast
        best_i = i
        best_j = j
      end
    end
    j += 1
  end
  i += 1
end

puts "#{best} (#{best_i}, #{best_j})"
