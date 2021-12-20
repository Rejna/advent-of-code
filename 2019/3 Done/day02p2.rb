# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 2 Part 2
# https://adventofcode.com/2019/day/2#part2
# Answer is: 8018

# input = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]
input = File.readlines('../1 Input/day02.input')[0].strip.split(',').map(&:to_i)

noun = 0
done = false

while noun < 100
  verb = 0
  while verb < 100
    pointer = 0
    memory = [*input]
    memory[1] = noun
    memory[2] = verb

    loop do
      op = input[pointer]

      case op
      when 1
        val1 = memory[memory[pointer + 1]]
        val2 = memory[memory[pointer + 2]]
        addr = memory[pointer + 3]
        memory[addr] = val1 + val2
      when 2
        val1 = memory[memory[pointer + 1]]
        val2 = memory[memory[pointer + 2]]
        addr = memory[pointer + 3]
        memory[addr] = val1 * val2
      when 99
        break
      end
      pointer += 4
    end

    if memory[0] == 19_690_720
      puts 100 * noun + verb
      done = true
    end
    verb += 1
    break if done
  end
  noun += 1
  break if done
end
