# frozen_string_literal: true

require 'date'

# Solution to Advent of Code 2018 Day 4 Part 1
# https://adventofcode.com/2018/day/4
# Answer is: 12169

# input = ['[1518-11-05 00:55] wakes up', '[1518-11-01 00:00] Guard #10 begins shift', '[1518-11-01 00:05] falls asleep',
#          '[1518-11-01 00:25] wakes up', '[1518-11-01 00:30] falls asleep', '[1518-11-01 00:55] wakes up',
#          '[1518-11-01 23:58] Guard #99 begins shift', '[1518-11-02 00:40] falls asleep', '[1518-11-02 00:50] wakes up',
#          '[1518-11-03 00:05] Guard #10 begins shift', '[1518-11-03 00:24] falls asleep', '[1518-11-03 00:29] wakes up',
#          '[1518-11-04 00:02] Guard #99 begins shift', '[1518-11-04 00:36] falls asleep', '[1518-11-04 00:46] wakes up',
#          '[1518-11-05 00:03] Guard #99 begins shift', '[1518-11-05 00:45] falls asleep']

input = File.readlines('../1 Input/day04.input').map(&:strip)

sorted_input = []

input.each do |entry|
  ent = entry.gsub('[', '').split('] ')
  timestamp = ent[0]
  action = ent[1]

  date = DateTime.parse(timestamp)
  sorted_input << [date, action]
end

sorted_input = sorted_input.sort_by { |e| e[0] }

current_guard = 0
sleep_times = {}
start_minute = 0
end_minute = 0

sorted_input.each do |entry|
  minute = entry[0].minute
  action = entry[1]

  if action.include?('Guard')
    current_guard = action.split(' ')[1].gsub('#', '').to_i
  elsif action.include?('falls')
    start_minute = minute
  else
    sleep_times[current_guard] = Array.new(60, 0) unless sleep_times.keys.include?(current_guard)
    end_minute = minute

    i = start_minute
    while i < end_minute
      sleep_times[current_guard][i] += 1
      i += 1
    end
    start_minute = 0
    end_minute = 0
  end
end

the_sleepiest_guard = sleep_times.max_by { |_k, v| v.sum }
the_sleepiest_minute = the_sleepiest_guard[1].index(the_sleepiest_guard[1].max)
puts the_sleepiest_minute * the_sleepiest_guard[0]
