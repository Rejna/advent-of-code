# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 20 Part 1
# https://adventofcode.com/2020/day/20
# Answer is: ???

require 'matrix'

m = Matrix[
    [1, 2],
    [2, 3]
]
m = m.rotate_entries
puts m
