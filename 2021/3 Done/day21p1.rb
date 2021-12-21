# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 21 Part 1
# https://adventofcode.com/2021/day/21
# Answer is: 900099

# player_one = 4
# player_two = 8
input = File.readlines('../1 Input/day21.input').map(&:strip)
player_one = input[0].gsub('Player 1 starting position: ', '').to_i
player_two = input[1].gsub('Player 2 starting position: ', '').to_i

player_one_score = 0
player_two_score = 0
die = 1

loop do
  player_one = ((player_one + die + die + 1 + die + 2) % 10)
  player_one = 10 if player_one.zero?
  player_one_score += player_one
  die += 3
  puts "P1 #{player_one} #{player_one_score}"
  break if player_one_score >= 1000

  player_two = ((player_two + die + die + 1 + die + 2) % 10)
  player_two = 10 if player_two.zero?
  player_two_score += player_two
  die += 3
  puts "P2 #{player_two} #{player_two_score}"
  break if player_two_score >= 1000
end

# winners_score = player_one_score > player_two_score ? player_one_score : player_two_score
losers_score = player_one_score < player_two_score ? player_one_score : player_two_score
result = losers_score * (die - 1)
# puts "Winner's score: #{winners_score}"
# puts "Loser's score: #{losers_score}"
# puts "Dice rolls: #{die - 1}"
# puts "Result: #{result}"
puts result
