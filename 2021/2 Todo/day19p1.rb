# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 19 Part 1
# https://adventofcode.com/2021/day/19
# Answer is: ???

require 'matrix'

input = File.readlines('1 Input/day19test.input').map(&:strip)
# input = File.readlines('1 Input/day19.input').map(&:strip)

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
             [[-1, 0, 0], [0, 1, 0], [0, 0, -1]], # <--
             [[-1, 0, 0], [0, 0, 0], [0, 1, 0]],
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

def mult(matrix, point)
  r = Matrix[*matrix]
  p = Matrix[point].transpose

  (r * p).to_a.flatten
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

matched_scanners = []
found_beacons = {}

scanners.each do |k1, v1|
  scanners.each do |k2, v2|
    next if k1 == k2 || matched_scanners.include?([k1, k2])

    # puts "#{k1} #{k2}"
    # pp v1
    # pp v2

    rotations.each do |rotation|
      differences = {}

      v1.each do |vv|
        v2.each do |vvv|
          rot = mult(rotation, vv)
          a = mult(rotation, [rot[0] - vvv[0], rot[1] - vvv[1], rot[2] - vvv[2]])

          differences[a] << [vv, vvv] if differences.key?(a)
          differences[a] = [[vv, vvv]] unless differences.key?(a)

          i += 1
        end
      end

      if differences.values.map(&:length).include?(12)
        # puts 'bang'
        # puts "#{k1} #{k2}"
        # puts "rotation #{rotation}"
        target = differences.select { |_, v| v.length == 12 }.to_h.values

        target[0].each do |val|
          if (!found_beacons.key?(k2) || !found_beacons[k2].include?(val[1])) && (!found_beacons.key?(k1) || !found_beacons[k1].include?(val[0]))
            found_beacons[k1] << val[0] if found_beacons.key?(k1)
            found_beacons[k1] = [val[0]] unless found_beacons.key?(k1)
            found_beacons[k2] << val[1] if found_beacons.key?(k2)
            found_beacons[k2] = [val[1]] unless found_beacons.key?(k2)
          else
            next
          end
        end
        # pp found_beacons
        matched_scanners << [k1, k2]
        matched_scanners << [k2, k1]
        # gets
      end
    end
  end
end

puts found_beacons.values.map(&:length).sum