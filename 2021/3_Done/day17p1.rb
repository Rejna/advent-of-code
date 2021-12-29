# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 17 Part 1
# https://adventofcode.com/2021/day/17
# Answer is: 7381

# input = 'target area: x=20..30, y=-10..-5'.gsub('target area: ', '').split(', ')
input = File.readlines('../1_Input/day17.input').map(&:strip)[0].gsub('target area: ', '').split(', ')

area_x = input[0].gsub('x=', '').split('..').map(&:to_i)
area_y = input[1].gsub('y=', '').split('..').map(&:to_i)

x_min = area_x[0]
x_max = area_x[1]
y_min = area_y[0]
y_max = area_y[1]

start_v_x = 1
start_v_y = y_min

max_height = -999_999_999

while start_v_x <= x_max
  start_v_y = y_min
  while start_v_y <= -y_min
    x = 0
    y = 0
    v_x = start_v_x
    v_y = start_v_y
    local_max_height = -999_999_999

    loop do
      x += v_x
      y += v_y
      local_max_height = y if y > local_max_height

      break if x > x_max || y < y_min

      if x >= x_min && x <= x_max && y >= y_min && y <= y_max
        if local_max_height > max_height
          max_height = local_max_height
          # puts "#{start_v_x},#{start_v_y} #{max_height}"
        end
        break
      end

      v_x = if v_x.positive?
              v_x - 1
            elsif v_x.negative?
              v_x + 1
            else
              v_x
            end
      v_y -= 1
    end
    start_v_y += 1
  end
  start_v_x += 1
end

puts max_height
