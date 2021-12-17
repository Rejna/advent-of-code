# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 5 Part 1
# https://adventofcode.com/2020/day/5
# Answer is: 861

# input = %w[FBFBBFFRLR BFFFBBFRRR FFFBBBFRRR BBFFBBFRLL]
input = File.readlines('../1 Input/day05.input').map(&:strip)

max = 0
input.each do |ticket|
  min_r = 1
  max_r = 128
  min_c = 1
  max_c = 8
  ticket = ticket.split('')
  ticket.each do |c|
    case c
    when 'F'
      max_r -= (max_r - min_r + 1) / 2
    when 'B'
      min_r += (max_r - min_r + 1) / 2
    when 'L'
      max_c -= (max_c - min_c + 1) / 2
    when 'R'
      min_c += (max_c - min_c + 1) / 2
    end
  end
  min_r -= 1
  min_c -= 1
  seat_id = min_r * 8 + min_c
  # puts "row #{min_r} col #{min_c} seatID #{seat_id}"
  max = seat_id if seat_id > max
end

puts max
