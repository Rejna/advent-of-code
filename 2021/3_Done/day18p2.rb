# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 18 Part 2
# https://adventofcode.com/2021/day/18#part2
# Answer is: 4659 in ~12s

def magnitude(number)
  if number.length == 1 # one digit
    number.to_i
  elsif number =~ /^\[\d,\d\]$/ # pair [x, y]
    sp = number[1, 3].split(',').map(&:to_i)
    3 * sp[0] + 2 * sp[1]
  else
    i = 0
    depth = -1
    while i < number.length
      if number[i] == '['
        depth += 1
      elsif number[i] == ']'
        depth -= 1
      elsif depth.zero? && number[i] == ','
        lhs = number[1..i - 1]
        rhs = number[i + 1..number.length - 2]
        return 3 * magnitude(lhs) + 2 * magnitude(rhs)
      end
      i += 1
    end
  end
end

def reduce(input)
  allow_split = false
  loops_since_last_event = 0

  loop do
    i = 0
    depth = -1
    explosion_happened = false
    split_happened = false

    while i < input.length
      case input[i]
      when '['
        depth += 1
      when ']'
        depth -= 1
      else
        number = 0
        comma = 0
        if input[i] =~ /\d/
          if input[i + 1] == ','
            number = input[i].to_i
            comma = i + 1
          elsif input[i + 1] =~ /\d/
            number = input[i, 2].to_i
            comma = i + 2
          end
        end

        if number >= 10 && allow_split
          split_left = (number.to_f / 2).floor
          split_right = (number.to_f / 2).ceil
          new_element = "[#{split_left},#{split_right}]"

          input = input[0..i - 1] + new_element + input[comma..]
          allow_split = false
          split_happened = true
          explosion_happened = false
          loops_since_last_event = 0
          break
        end
      end

      if depth >= 4 &&
         ((input[i, 5] =~ /\[\d{1,2},\d{1,2}\]/) || # both one digit
         (input[i, 6] =~ /\[\d{1,2},\d{1,2}\]/) || # one digit + two digits
         (input[i, 7] =~ /\[\d{1,2},\d{1,2}\]/)) # both two digits

        explosion_happened = true
        allow_split = false
        loops_since_last_event = 0

        left_number = if input[i + 2] == ',' # one digit left number
                        input[i + 1].to_i
                      else                   # two digits left number
                        input[i + 1, 2].to_i
                      end
        left_part = input[0..i - 1]

        if left_number >= 10
          if input[i + 5] == ']'              # two digits left number, one digit right number
            right_number = input[i + 4].to_i
            right_part = input[(i + 6)..]
          else                                # two digits left number, two digits right number
            right_number = input[i + 4, 2].to_i
            right_part = input[(i + 7)..]
          end
        elsif input[i + 4] == ']'             # one digit left number, one digit right number
          right_number = input[i + 3].to_i
          right_part = input[(i + 5)..]
        else                                  # one digit left number, two digits right number
          right_number = input[i + 3, 2].to_i
          right_part = input[(i + 6)..]
        end

        z = i - 1
        z -= 1 until left_part[z] =~ /\d/ || z.zero?

        unless z.zero?
          if left_part[z - 1] =~ /\d/
            first_left_number = left_part[z - 1, 2].to_i
            new_element = first_left_number + left_number
            left_part = "#{left_part[0..z - 2]}#{new_element}#{left_part[z + 1..]}"
          else
            first_left_number = left_part[z].to_i
            new_element = first_left_number + left_number
            left_part = "#{left_part[0..z - 1]}#{new_element}#{left_part[z + 1..]}"
          end
        end

        z = 0
        z += 1 until right_part[z] =~ /\d/ || z == right_part.length
        unless z == right_part.length
          if right_part[z + 1] =~ /\d/
            first_right_number = right_part[z, 2].to_i
            new_element = first_right_number + right_number
            right_part = "#{right_part[0..z - 1]}#{new_element}#{right_part[z + 2..]}"
          else
            first_right_number = right_part[z].to_i
            new_element = first_right_number + right_number
            right_part = "#{right_part[0..z - 1]}#{new_element}#{right_part[z + 1..]}"
          end
        end

        input = "#{left_part}0#{right_part}"
        break
      else
        i += 1
      end
    end

    allow_split = !explosion_happened
    loops_since_last_event += 1 if !explosion_happened && !split_happened
    break if loops_since_last_event >= 2
  end
  input
end

# inputs = File.readlines('../1_Input/day18homework.input').map(&:strip)
inputs = File.readlines('../1_Input/day18.input').map(&:strip)
max_magnitude = 0
# max_lhs = ''
# max_rhs = ''
done = {}

inputs.each do |lhs|
  inputs.each do |rhs|
    next if lhs == rhs

    input = "[#{lhs},#{rhs}]"
    next if done[input]

    done[input] = true
    reduced = reduce(input)
    mag = magnitude(reduced)
    if mag > max_magnitude
      max_magnitude = mag
      # max_lhs = lhs
      # max_rhs = rhs
    end

    input = "[#{rhs},#{lhs}]"
    next if done[input]

    done[input] = true
    reduced = reduce(input)
    mag = magnitude(reduced)
    next unless mag > max_magnitude

    max_magnitude = mag
    # max_lhs = rhs
    # max_rhs = lhs
  end
end

puts max_magnitude
# puts max_lhs
# puts max_rhs
