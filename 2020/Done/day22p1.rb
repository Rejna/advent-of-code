# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 22 Part 1
# https://adventofcode.com/2020/day/22
# Answer is: 35562

# player1 = [9, 2, 6, 3, 1]
# player2 = [5, 8, 4, 7, 10]

player1 = [24, 22, 26, 6, 14, 19, 27, 17, 39, 34, 40, 41, 23, 30, 36, 11, 28, 3, 10, 21, 9, 50, 32, 25, 8]
player2 = [48, 49, 47, 15, 42, 44, 5, 4, 13, 7, 20, 43, 12, 37, 29, 18, 45, 16, 1, 46, 38, 35, 2, 33, 31]

i = 1
loop do
  puts "-- Round #{i} --"
  puts "Player 1's deck: #{player1.join(', ')}"
  puts "Player 2's deck: #{player2.join(', ')}"
  player1_card = player1.reverse!.pop
  player2_card = player2.reverse!.pop
  puts "Player 1 plays: #{player1_card}"
  puts "Player 2 plays: #{player2_card}"
  player1.reverse!
  player2.reverse!
  if player1_card > player2_card
    player1 << player1_card
    player1 << player2_card
    puts 'Player 1 wins the round!'
  else
    player2 << player2_card
    player2 << player1_card
    puts 'Player 2 wins the round!'
  end
  puts
  i += 1
  break if player1.empty? || player2.empty?
end

puts '== Post-game results =='
puts "Player's 1 deck: #{player1.join(', ')}"
puts "Player's 2 deck: #{player2.join(', ')}"
score = player1.empty? ? player2.length : player1.length
total_score = 0

if player1.empty?
  player2.each do |card|
    total_score += score * card
    score -= 1
  end
else
  player1.each do |card|
    total_score += score * card
    score -= 1
  end
end

puts "Winner's score: #{total_score}"
