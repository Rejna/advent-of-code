# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 12 Part 2
# https://adventofcode.com/2020/day/12#part2
# Answer is: 63843

# input = %w[F10 N3 F7 R90 F11]
input = File.readlines('../1 Input/day12.input').map(&:strip)

@x = 0
@y = 0
@wx = 1
@wy = 10

def rotate(dir, deg)
  temp_wx = @wx
  temp_wy = @wy
  if deg == 90
    if dir == 'R'
      @wx = temp_wy * -1
      @wy = temp_wx
    else
      @wx = temp_wy
      @wy = temp_wx * -1
    end
  elsif deg == 180
    @wx = temp_wx * -1
    @wy = temp_wy * -1
  elsif dir == 'R' # 270
    @wx = temp_wy
    @wy = temp_wx * -1
  else
    @wx = temp_wy * -1
    @wy = temp_wx
  end
end

def move_w(dir, dist)
  case dir
  when 'N'
    @wx += dist
  when 'E'
    @wy += dist
  when 'W'
    @wy -= dist
  when 'S'
    @wx -= dist
  end
end

def move_s(dist)
  @x += @wx * dist
  @y += @wy * dist
end

def get_x(val)
  val >= 0 ? 'N' : 'S'
end

def get_y(val)
  val >= 0 ? 'E' : 'W'
end

input.each do |command|
  c = command[0]
  param = command[1..].to_i
  case c
  when 'N', 'E', 'W', 'S'
    # puts "move #{c} #{param} units"
    move_w(c, param)
  when 'R', 'L'
    # puts "rotate #{c} #{param} degrees"
    rotate(c, param)
  when 'F'
    # puts "move #{@direction} #{param} units"
    move_s(param)
  end
  # puts "#{command} #{@y}#{get_y(@y)} #{@x}#{get_x(@x)} | #{@wy}#{get_y(@wy)} #{@wx}#{get_x(@wx)}"
end

puts @x.abs + @y.abs
