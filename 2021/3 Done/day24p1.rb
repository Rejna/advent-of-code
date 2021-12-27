# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 24 Part 1
# https://adventofcode.com/2021/day/24
# Answer is: 94992994195998

input = File.readlines('../1 Input/day24.input').map(&:strip)

commands_per_digit = []
inp = ['inp w']
input[1..].each do |command|
  if command.include?('inp')
    commands_per_digit << inp
    inp = []
  end
  inp << command
end
commands_per_digit << inp

z_divisors = []
x_adders = []
y_adders = []

i = 0
while i < 14
  j = 0
  while j < 18
    command = commands_per_digit[i][j]
    if command =~ /div z \d{1,2}/
      sp = command.split(' ')
      z_divisors << sp[2].to_i
    elsif command =~ /add x -{0,1}\d{1,2}/
      sp = command.split(' ')
      x_adders << sp[2].to_i
    elsif command =~ /add y \d{1,2}/ && j > 11
      sp = command.split(' ')
      y_adders << sp[2].to_i
    end
    j += 1
  end
  i += 1
end

number = 99_999_999_999_999

loop do
  if number.to_s.include?('0')
    x = number.to_s.rindex('0')
    exp = 10**(14 - x - 1)
    number -= exp
    next
  end

  z = 0
  i = 0
  inner_loop_broken = false
  while i < 14
    digit = number.to_s[i].to_i
    x = (z % 26) + x_adders[i]
    z /= z_divisors[i]
    if x != digit
      z = (26 * z) + digit + y_adders[i]
      if x_adders[i].negative?
        inner_loop_broken = true
        break
      end
    end
    i += 1
  end

  if z.zero?
    puts number
    break
  end

  if inner_loop_broken
    number -= 10**(13 - i)
    next
  end

  number -= 1
end
