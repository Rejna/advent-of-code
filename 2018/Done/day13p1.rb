# frozen_string_literal: false

# Solution to Advent of Code 2018 Day 13 Part 1
# https://adventofcode.com/2018/day/13
# Answer is: 48,20

# @input = ['/->-\        ',
#           '|   |  /----\\',
#           '| /-+--+-\  |',
#           '| | |  | v  |',
#           '\-+-/  \-+--/',
#           '  \------/   ']

@input = File.readlines('day13.input').map { |a| a.gsub(' ', '.') }.map(&:strip)
@trains = []

def action(train)
  cur_position = train[:position]
  cur_direction = train[:direction]
  cur_turn = train[:turn]

  new_train = train.clone

  next_tile = case cur_direction
              when 'up'
                @input[cur_position[0] - 1][cur_position[1]]
              when 'down'
                @input[cur_position[0] + 1][cur_position[1]]
              when 'left'
                @input[cur_position[0]][cur_position[1] - 1]
              else
                @input[cur_position[0]][cur_position[1] + 1]
              end

  new_train[:position] = move(cur_position, cur_direction)

  case next_tile
  when '\\', '/'
    new_train[:direction] = char_to_direction(turn(next_tile, cur_direction, cur_turn))
  when '+'
    new_train[:direction] = char_to_direction(turn(next_tile, cur_direction, cur_turn))
    new_train[:turn] = next_turn(cur_turn)
  end

  new_train
end

def turn(track_type, current_direction, current_turn)
  case track_type
  when '+'
    case current_direction
    when 'down'
      case current_turn
      when 'left'
        '>'
      when 'right'
        '<'
      else
        'v'
      end
    when 'up'
      case current_turn
      when 'left'
        '<'
      when 'right'
        '>'
      else
        '^'
      end
    when 'left'
      case current_turn
      when 'left'
        'v'
      when 'right'
        '^'
      else
        '<'
      end
    else
      case current_turn
      when 'left'
        '^'
      when 'right'
        'v'
      else
        '>'
      end
    end
  when '\\'
    case current_direction
    when 'left'
      '^'
    when 'right'
      'v'
    when 'up'
      '<'
    else
      '>'
    end
  when '/'
    case current_direction
    when 'left'
      'v'
    when 'right'
      '^'
    when 'up'
      '>'
    else
      '<'
    end
  end
end

def move(current_postion, current_direction)
  i = current_postion[0]
  j = current_postion[1]

  case current_direction
  when 'up'
    [i - 1, j]
  when 'down'
    [i + 1, j]
  when 'left'
    [i, j - 1]
  else
    [i, j + 1]
  end
end

def next_turn(current_turn)
  case current_turn
  when 'left'
    'straight'
  when 'straight'
    'right'
  else
    'left'
  end
end

def char_to_direction(c)
  case c
  when '>'
    'right'
  when '<'
    'left'
  when '^'
    'up'
  else
    'down'
  end
end

def direction_to_char(dir)
  case dir
  when 'left'
    '<'
  when 'right'
    '>'
  when 'up'
    '^'
  else
    'v'
  end
end

def print_tracks
  i = 0
  while i < @input.length
    j = 0
    while j < @input[i].length
      t = @trains.select { |v| v[:position] == [i, j] }[0]
      putc direction_to_char(t[:direction]) unless t.nil?
      putc @input[i][j] if t.nil?
      j += 1
    end
    puts
    i += 1
  end
  puts
end

i = 0
while i < @input.length
  j = 0
  while j < @input[i].length
    if %w[> < v ^].include?(@input[i][j])
      @trains << { position: [i, j], direction: char_to_direction(@input[i][j]), turn: 'left' }

      @input[i][j] = '-' if %w[> <].include?(@input[i][j])
      @input[i][j] = '|' if %w[^ v].include?(@input[i][j])
    end
    j += 1
  end
  i += 1
end

loop do
  @trains = @trains.sort_by { |v| [v[:position][0], v[:position][1]] }
  new_trains = []

  @trains.each do |train|
    new_train = action(train)
    new_trains << new_train
  end

  @trains = new_trains
  # print_tracks
  # gets

  tally = @trains.map { |t| t[:position] }.tally
  if tally.values.include?(2)
    puts "#{tally.key(2)[1]},#{tally.key(2)[0]}"
    break
  end
end
