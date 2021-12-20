# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 12 Part 1
# https://adventofcode.com/2019/day/12
# Answer is: 9493

class Moon
  attr_accessor :x, :y, :z, :vel_x, :vel_y, :vel_z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
    @vel_x = 0
    @vel_y = 0
    @vel_z = 0
  end

  def calculate_gravity_change(other_moon)
    delta_this = [0, 0, 0]
    delta_other = [0, 0, 0]

    if @x != other_moon.x
      if @x < other_moon.x
        delta_this[0] += 1
        delta_other[0] -= 1
      else
        delta_this[0] -= 1
        delta_other[0] += 1
      end
    end

    if @y != other_moon.y
      if @y < other_moon.y
        delta_this[1] += 1
        delta_other[1] -= 1
      else
        delta_this[1] -= 1
        delta_other[1] += 1
      end
    end

    return [delta_this, delta_other] unless @z != other_moon.z

    if @z < other_moon.z
      delta_this[2] += 1
      delta_other[2] -= 1
    else
      delta_this[2] -= 1
      delta_other[2] += 1
    end

    [delta_this, delta_other]
  end

  def apply_gravity_and_move(delta)
    @vel_x += delta[0]
    @vel_y += delta[1]
    @vel_z += delta[2]
    move
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @z += @vel_z
  end

  def energy
    (@x.abs + @y.abs + @z.abs) * (@vel_x.abs + @vel_y.abs + @vel_z.abs)
  end

  def to_s
    "pos=<x=#{@x}, y=#{@y}, z=#{@z}>, vel=<x=#{@vel_x}, y=#{@vel_y}, z=#{@vel_z}>"
  end
end

def add_arrs(arr1, arr2)
  [arr1[0] + arr2[0], arr1[1] + arr2[1], arr1[2] + arr2[2]]
end

# io = Moon.new(-1, 0, 2)
# europa = Moon.new(2, -10, -7)
# callisto = Moon.new(4, -8, 8)
# ganymede = Moon.new(3, 5, -1)

# io = Moon.new(-8, -10, 0)
# europa = Moon.new(5, 5, 10)
# callisto = Moon.new(2, -7, 3)
# ganymede = Moon.new(9, -8, -3)

io = Moon.new(4, 1, 1)
europa = Moon.new(11, -18, -1)
callisto = Moon.new(-2, -10, -4)
ganymede = Moon.new(-7, -2, 14)

puts 'After 0 steps:'
puts io
puts europa
puts callisto
puts ganymede
puts

steps = 0
while steps < 1000
  delta_io = [0, 0, 0]
  delta_europa = [0, 0, 0]
  delta_ganymede = [0, 0, 0]
  delta_callisto = [0, 0, 0]

  d1, d2 = io.calculate_gravity_change(europa)
  delta_io = add_arrs(delta_io, d1)
  delta_europa = add_arrs(delta_europa, d2)

  d1, d2 = europa.calculate_gravity_change(callisto)
  delta_europa = add_arrs(delta_europa, d1)
  delta_callisto = add_arrs(delta_callisto, d2)

  d1, d2 = io.calculate_gravity_change(callisto)
  delta_io = add_arrs(delta_io, d1)
  delta_callisto = add_arrs(delta_callisto, d2)

  d1, d2 = io.calculate_gravity_change(ganymede)
  delta_io = add_arrs(delta_io, d1)
  delta_ganymede = add_arrs(delta_ganymede, d2)

  d1, d2 = callisto.calculate_gravity_change(ganymede)
  delta_callisto = add_arrs(delta_callisto, d1)
  delta_ganymede = add_arrs(delta_ganymede, d2)

  d1, d2 = europa.calculate_gravity_change(ganymede)
  delta_europa = add_arrs(delta_europa, d1)
  delta_ganymede = add_arrs(delta_ganymede, d2)

  io.apply_gravity_and_move(delta_io)
  europa.apply_gravity_and_move(delta_europa)
  ganymede.apply_gravity_and_move(delta_ganymede)
  callisto.apply_gravity_and_move(delta_callisto)

  steps += 1

  next unless (steps % 100).zero?

  puts "After #{steps} steps:"
  puts io
  puts europa
  puts callisto
  puts ganymede
  puts "Total energy: #{io.energy + europa.energy + callisto.energy + ganymede.energy}"
  puts
end
