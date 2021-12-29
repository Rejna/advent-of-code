# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 19 Part 1
# https://adventofcode.com/2021/day/19
# Answer is: 436 in 1m27s

require 'matrix'

# input = File.readlines('../1_Input/day19test.input').map(&:strip)
input = File.readlines('../1_Input/day19.input').map(&:strip)

rotations = [[[1, 0, 0], [0, 1, 0], [0, 0, 1]],
             [[1, 0, 0], [0, 0, -1], [0, 1, 0]],
             [[1, 0, 0], [0, -1, 0], [0, 0, -1]],
             [[1, 0, 0], [0, 0, 1], [0, -1, 0]],
             [[0, -1, 0], [1, 0, 0], [0, 0, 1]],
             [[0, 0, 1], [1, 0, 0], [0, 1, 0]],
             [[0, 1, 0], [1, 0, 0], [0, 0, -1]],
             [[0, 0, -1], [1, 0, 0], [0, -1, 0]],
             [[-1, 0, 0], [0, -1, 0], [0, 0, 1]],
             [[-1, 0, 0], [0, 0, -1], [0, -1, 0]],
             [[-1, 0, 0], [0, 1, 0], [0, 0, -1]],
             [[-1, 0, 0], [0, 0, 1], [0, 1, 0]],
             [[0, 1, 0], [-1, 0, 0], [0, 0, 1]],
             [[0, 0, 1], [-1, 0, 0], [0, -1, 0]],
             [[0, -1, 0], [-1, 0, 0], [0, 0, -1]],
             [[0, 0, -1], [-1, 0, 0], [0, 1, 0]],
             [[0, 0, -1], [0, 1, 0], [1, 0, 0]],
             [[0, 1, 0], [0, 0, 1], [1, 0, 0]],
             [[0, 0, 1], [0, -1, 0], [1, 0, 0]],
             [[0, -1, 0], [0, 0, -1], [1, 0, 0]],
             [[0, 0, -1], [0, -1, 0], [-1, 0, 0]],
             [[0, -1, 0], [0, 0, 1], [-1, 0, 0]],
             [[0, 0, 1], [0, 1, 0], [-1, 0, 0]],
             [[0, 1, 0], [0, 0, -1], [-1, 0, 0]]]

def rotate(matrix, point)
  r = Matrix[*matrix]
  p = Matrix[point].transpose

  (r * p).to_a.flatten
end

def translate(point, vector)
  [point[0] + vector[0], point[1] + vector[1], point[2] + vector[2]]
end

scanners = {}
scanner = []
i = -1

input.each do |line|
  if line[0, 2] == '--'
    i += 1
    scanner = []
  elsif line == ''
    scanners[i] = scanner
  else
    scanner << line.split(',').map(&:to_i)
  end
end
scanners[i] = scanner

scanner_positions = {}
scanner_positions[0] = [0, 0, 0]
fixed_beacons = scanners[0].clone

while scanner_positions.length != scanners.length
  scanners.reject { |k, _| scanner_positions.key?(k) }.each do |k2, v2|
    done = false
    rotations.each do |rotation|
      differences = {}

      fixed_beacons.each do |vv|
        v2.each do |vvv|
          rot = rotate(rotation, vvv)
          a = [vv[0] - rot[0], vv[1] - rot[1], vv[2] - rot[2]]

          differences[a] << [vv, vvv] if differences.key?(a)
          differences[a] = [[vv, vvv]] unless differences.key?(a)

          if differences[a].length == 12
            done = true
            puts 'bang'
            puts "matched scanner #{k2}"
            puts "orientation #{rotation}"
            puts "scanner #{k2} location: #{a}"
            puts "scanners left to find: #{scanners.length - scanner_positions.length - 1}"
            puts

            scanner_positions[k2] = a

            b = 0
            while b < scanners[k2].length
              scanners[k2][b] = translate(rotate(rotation, scanners[k2][b]), a)
              fixed_beacons << scanners[k2][b] unless fixed_beacons.include?(scanners[k2][b])
              b += 1
            end
          end
          break if done
        end
        break if done
      end
      break if done
    end
  end
end

pp fixed_beacons.length
