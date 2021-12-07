# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 13 Part 2
# https://adventofcode.com/2020/day/13#part2
# Answer is: 538703333547789

def extended_gcd(a, b)
  last_remainder = a.abs
  remainder = b.abs
  x = 0
  last_x = 1
  while remainder != 0
    last_remainder = remainder
    (quotient, remainder) = last_remainder.divmod(remainder)
    x, last_x = last_x - quotient * x, x
  end
  [last_remainder, last_x * (a.negative? ? -1 : 1)]
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  raise 'Multiplicative inverse modulo does not exist!' if g != 1

  x % et
end

def chinese_remainder(mods, remainders)
  max = mods.inject(:*) # product of all moduli
  series = remainders.zip(mods).map { |r, m| (r * max * invmod(max / m, m) / m) }
  series.inject(:+) % max
end

# input = '7,13,x,x,59,x,31,19'
# rubocop:disable Layout/LineLength
input = '19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,751,x,29,x,x,x,x,x,x,x,x,x,x,13,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,431,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,17'
# rubocop:enable Layout/LineLength

i = 0
mods = []
remainders = []
input.split(',').each do |var|
  unless var == 'x'
    mods << var.to_i
    remainders << var.to_i - i
  end
  i += 1
end

pp mods
pp remainders
puts chinese_remainder(mods, remainders)
