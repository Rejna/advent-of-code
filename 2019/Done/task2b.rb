# frozen_string_literal: true

# input = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]
input = [1, 0, 0, 3, 1, 1, 2, 3, 1, 3, 4, 3, 1, 5, 0, 3, 2, 1, 9, 19, 1, 19, 5, 23, 2, 6, 23, 27, 1, 6, 27, 31, 2, 31,
         9, 35, 1, 35, 6, 39, 1, 10, 39, 43, 2, 9, 43, 47, 1, 5, 47, 51, 2, 51, 6, 55, 1, 5, 55, 59, 2, 13, 59, 63, 1,
         63, 5, 67, 2, 67, 13, 71, 1, 71, 9, 75, 1, 75, 6, 79, 2, 79, 6, 83, 1, 83, 5, 87, 2, 87, 9, 91, 2, 9, 91, 95,
         1, 5, 95, 99, 2, 99, 13, 103, 1, 103, 5, 107, 1, 2, 107, 111, 1, 111, 5, 0, 99, 2, 14, 0, 0]

noun = 0
done = false

while noun < 100
  verb = 0
  while verb < 100
    pointer = 0
    memory = [*input]
    memory[1] = noun
    memory[2] = verb

    while true
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
      puts "#{noun} #{verb} #{100 * noun + verb}"
      done = true
    end
    verb += 1
    break if done
  end
  noun += 1
  break if done
end
