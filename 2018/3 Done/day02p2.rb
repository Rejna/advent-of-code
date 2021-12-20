# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 2 Part 2
# https://adventofcode.com/2018/day/2#part2
# Answer is: tiwcdpbseqhxryfmgkvjujvza

def comp_strings(a, b)
  i = 0
  diff = 0
  while i < a.length
    diff += 1 if a[i] != b[i]
    i += 1
  end
  diff
end

def eq_chars_in_strings(a, b)
  i = 0
  eq = ''
  while i < a.length
    eq += a[i] if a[i] == b[i]
    i += 1
  end
  eq
end

# input = %w[abcde fghij klmno pqrst fguij axcye wvxyz]
input = File.readlines('../1 Input/day02.input').map(&:strip)

i = 0
done = false
while i < input.length
  j = 0
  while j < input.length
    if j == i
      j += 1
      next
    end

    diff = comp_strings(input[i], input[j])
    j += 1
    next if diff != 1

    puts eq_chars_in_strings(input[i], input[j - 1])
    done = true
    break
  end
  break if done

  i += 1
end
