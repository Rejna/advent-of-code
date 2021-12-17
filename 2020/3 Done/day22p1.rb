# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 22 Part 1
# https://adventofcode.com/2020/day/22
# Answer is: 35562

# player1 = [9, 2, 6, 3, 1]
# player2 = [5, 8, 4, 7, 10]

player1 = []
player2 = []
raw_input = File.readlines('../1 Input/day22.input').map(&:strip)
p2 = false

raw_input[1..].each do |row|
  if ['', 'Player 2:'].include?(row)
    p2 = true
  else
    player1 << row.to_i unless p2
    player2 << row.to_i if p2
  end
end

i = 1
loop do
  # puts "-- Round #{i} --"
  # puts "Player 1's deck: #{player1.join(', ')}"
  # puts "Player 2's deck: #{player2.join(', ')}"
  player1_card = player1.reverse!.pop
  player2_card = player2.reverse!.pop
  # puts "Player 1 plays: #{player1_card}"
  # puts "Player 2 plays: #{player2_card}"
  player1.reverse!
  player2.reverse!
  if player1_card > player2_card
    player1 << player1_card
    player1 << player2_card
    # puts 'Player 1 wins the round!'
  else
    player2 << player2_card
    player2 << player1_card
    # puts 'Player 2 wins the round!'
  end
  # puts
  i += 1
  break if player1.empty? || player2.empty?
end

# puts '== Post-game results =='
# puts "Player's 1 deck: #{player1.join(', ')}"
# puts "Player's 2 deck: #{player2.join(', ')}"
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

# puts "Winner's score: #{total_score}"
puts total_score
