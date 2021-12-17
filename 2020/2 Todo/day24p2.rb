# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 24 Part 2
# https://adventofcode.com/2020/day/24#part2
# Answer is: ???

def move(i, j, dir)
  case dir
  when 'w'
    [i, j - 2]
  when 'e'
    [i, j + 2]
  when 'nw'
    [i - 1, j - 1]
  when 'ne'
    [i - 1, j + 1]
  when 'sw'
    [i + 1, j - 1]
  when 'se'
    [i + 1, j + 1]
  end
end

def get_neighbours(i, j)
  neighbours = []
  %w[w e nw ne sw se].each do |dir|
    new_i, new_j = move(i, j, dir)
    begin
      neighbours << @floor[new_i][new_j]
    rescue StandardError
      neighbours << 'w'
    end
  end
  neighbours.tally
end

# input = %w[sesenwnenenewseeswwswswwnenewsewsw neeenesenwnwwswnenewnwwsewnenwseswesw seswneswswsenwwnwse
#            nwnwneseeswswnenewneswwnewseswneseene swweswneswnenwsewnwneneseenw eesenwseswswnenwswnwnwsewwnwsene
#            sewnenenenesenwsewnenwwwse wenwwweseeeweswwwnwwe wsweesenenewnwwnwsenewsenwwsesesenwne
#            neeswseenwwswnwswswnw nenwswwsewswnenenewsenwsenwnesesenew enewnwewneswsewnwswenweswnenwsenwsw
#            sweneswneswneneenwnewenewwneswswnese swwesenesewenwneswnwwneseswwne enesenwswwswneneswsenwnewswseenwsese
#            wnwnesenesenenwwnenwsewesewsesesew nenewswnwewswnenesenwnesewesw eneswnwswnwsenenwnwnwwseeswneewsenese
#            neswnwewnwnwseenwseesewsenwsweewe wseweeenwnesenwwwswnew]

input = File.readlines('../1 Input/day24.input').map(&:strip)

@floor = []
i = 0
while i < 100
  @floor << [*Array.new(100, 'w')]
  i += 1
end

@black_count = 0
input.each do |directions|
  i = 0
  start_x = 50
  start_y = 50
  dir_arr = []
  while i < directions.length
    case directions[i]
    when 'w', 'e'
      dir_arr << directions[i]
      i += 1
    when 'n', 's'
      dir_arr << "#{directions[i]}#{directions[i + 1]}"
      i += 2
    end
  end

  dir_arr.each do |dir|
    start_x, start_y = move(start_x, start_y, dir)
  end

  if @floor[start_x][start_y] == 'w'
    @floor[start_x][start_y] = 'b'
    @black_count += 1
  else
    @floor[start_x][start_y] = 'w'
    @black_count -= 1
  end
end

x = 1
while x <= 10
  new_floor = []
  z = 0
  while z < 100
    new_floor << [*Array.new(100, 'w')]
    z += 1
  end

  i = 0
  j = 0
  new_black_count = @black_count
  while i < 100
    while j < 100
      neighs = get_neighbours(i, j)['b']
      if @floor[i][j] == 'w' && neighs == 2
        new_floor[i][j] = 'b'
        new_black_count += 1
      elsif @floor[i][j] == 'b' && (neighs.zero? || neighs > 2)
        new_floor[i][j] = 'w'
        new_black_count -= 1
      else
        new_floor[i][j] = @floor[i][j]
      end
      j += 1
    end
    i += 1
  end
  @floor = new_floor
  puts "Day #{x}: #{new_black_count}"
  x += 1
end
