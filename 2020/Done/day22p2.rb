# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 22 Part 2
# https://adventofcode.com/2020/day/22#part2
# Answer is: 34424

# @player1 = [9, 2, 6, 3, 1]
# @player2 = [5, 8, 4, 7, 10]

# @player1 = [43, 19]
# @player2 = [2, 29, 14]

@player1 = [24, 22, 26, 6, 14, 19, 27, 17, 39, 34, 40, 41, 23, 30, 36, 11, 28, 3, 10, 21, 9, 50, 32, 25, 8]
@player2 = [48, 49, 47, 15, 42, 44, 5, 4, 13, 7, 20, 43, 12, 37, 29, 18, 45, 16, 1, 46, 38, 35, 2, 33, 31]

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
      else
        if player1_card > player2_card
          player1 << player1_card
          player1 << player2_card
          # puts "Player 1 wins round #{i} of game #{game_no}!"
        else
          player2 << player2_card
          player2 << player1_card
          # puts "Player 2 wins round #{i} of game #{game_no}!"
        end
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

puts '== Post-game results =='
puts "Player's 1 deck: #{@player1.join(', ')}"
puts "Player's 2 deck: #{@player2.join(', ')}"
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

puts "Winner's score: #{total_score}"
