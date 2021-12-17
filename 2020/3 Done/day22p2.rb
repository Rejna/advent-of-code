# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 22 Part 2
# https://adventofcode.com/2020/day/22#part2
# Answer is: 34424

# @player1 = [9, 2, 6, 3, 1]
# @player2 = [5, 8, 4, 7, 10]

# @player1 = [43, 19]
# @player2 = [2, 29, 14]

@player1 = []
@player2 = []
raw_input = File.readlines('../1 Input/day22.input').map(&:strip)
p2 = false

raw_input[1..].each do |row|
  if ['', 'Player 2:'].include?(row)
    p2 = true
  else
    @player1 << row.to_i unless p2
    @player2 << row.to_i if p2
  end
end

def play_game(game_no, player1, player2)
  # puts "=== Game #{game_no} ==="
  player1_history = []
  player2_history = []
  subgame_no = game_no + 1
  result = ''
  i = 1
  loop do
    if player1_history.include?(player1.join(',')) && player2_history.include?(player2.join(',')) &&
       player1_history.index(player1.join) == player2_history.index(player2.join)
      # puts "SAFETY NET"
      result = 'player 1'
      break
    else
      # puts
      # puts "-- Round #{i} (Game #{game_no}) --"
      # puts "Player 1's deck: #{player1.join(', ')}"
      # puts "Player 2's deck: #{player2.join(', ')}"
      player1_history << player1.join(',')
      player2_history << player2.join(',')
      player1_card = player1.reverse!.pop
      player2_card = player2.reverse!.pop
      player1.reverse!
      player2.reverse!
      # puts "Player 1 plays: #{player1_card}"
      # puts "Player 2 plays: #{player2_card}"

      if player1_card <= player1.length && player2_card <= player2.length
        # puts 'Playing a sub-game to determine the winner...'
        # puts
        new_player1 = [*player1.take(player1_card)]
        new_player2 = [*player2.take(player2_card)]
        recurse_result = play_game(subgame_no, new_player1, new_player2)
        subgame_no += 1
        # puts "...anyway, back to game #{game_no}."
        if recurse_result == 'player 1'
          player1 << player1_card
          player1 << player2_card
          # puts "Player 1 wins round #{i} of game #{game_no}!"
        else
          player2 << player2_card
          player2 << player1_card
          # puts "Player 2 wins round #{i} of game #{game_no}!"
        end
      elsif player1_card > player2_card
        player1 << player1_card
        player1 << player2_card
        # puts "Player 1 wins round #{i} of game #{game_no}!"
      else
        player2 << player2_card
        player2 << player1_card
        # puts "Player 2 wins round #{i} of game #{game_no}!"
      end
      i += 1
      result = player1.empty? ? 'player 2' : 'player 1'
      break if player1.empty? || player2.empty?
    end
  end
  # puts "The winner of game #{game_no} is #{result}!"
  # puts
  result
end

result = play_game(1, @player1, @player2)

# puts '== Post-game results =='
# puts "Player's 1 deck: #{@player1.join(', ')}"
# puts "Player's 2 deck: #{@player2.join(', ')}"
score = result == 'player 1' ? @player1.length : @player2.length
total_score = 0

if result == 'player 1'
  @player1.each do |card|
    total_score += score * card
    score -= 1
  end
else
  @player2.each do |card|
    total_score += score * card
    score -= 1
  end
end

# puts "Winner's score: #{total_score}"
puts total_score
