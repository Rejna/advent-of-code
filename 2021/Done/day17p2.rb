# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 17 Part 2
# https://adventofcode.com/2021/day/17#part2
# Answer is: 3019

# input = 'target area: x=20..30, y=-10..-5'.gsub('target area: ', '').split(', ')
input = File.readlines('day17.input').map(&:strip)[0].gsub('target area: ', '').split(', ')

area_x = input[0].gsub('x=', '').split('..').map(&:to_i)
area_y = input[1].gsub('y=', '').split('..').map(&:to_i)

x_min = area_x[0]
x_max = area_x[1]
y_min = area_y[0]
y_max = area_y[1]

start_v_x = 1
start_v_y = y_min

# speeds = []
speeds = {}

while start_v_x <= x_max
  start_v_y = y_min
  while start_v_y <= -y_min
    x = 0
    y = 0
    v_x = start_v_x
    v_y = start_v_y

    loop do
      x += v_x
      y += v_y

      break if x > x_max || y < y_min

      if x >= x_min && x <= x_max && y >= y_min && y <= y_max
        # speeds << [start_v_x, start_v_y] unless speeds.include?([start_v_x, start_v_y])
        speeds[[start_v_x, start_v_y]] = true unless speeds.key?([start_v_x, start_v_y])
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

puts speeds.length
