# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 12 Part 1
# https://adventofcode.com/2021/day/12
# Answer is: ???

class Graph
  def initialize
    @adj_list = {}
    @all_paths = []
  end

  def add_edge(u, v)
    @adj_list[u] << v if @adj_list.keys.include?(u)
    @adj_list[u] = [v] unless @adj_list.keys.include?(u)
  end

  def print_all_edges
    pp @adj_list
  end

  def print_all_paths(s, d)
    is_visited = {}
    path_list = []

    path_list << s

    print_all_paths_util(s, d, is_visited, path_list)
  end

  def print_all_paths_util(u, d, is_visited, local_path_list)
    if u == d && !@all_paths.include?(local_path_list.join(','))
      @all_paths << local_path_list.join(',')
      puts local_path_list.join(',')
      return
    end

    is_visited[u] = false
    is_visited[u] = true if u.split('').all? { |c| c == c.downcase }
    # is_visited[u] = true if u.downcase == u

    @adj_list[u].each do |i|
      next if is_visited[i]

      local_path_list << i
      print_all_paths_util(i, d, is_visited, local_path_list)
      local_path_list.delete(i)
    end

    is_visited[u] = false
  end
end

input = %w[start-A start-b A-c A-b b-d A-end b-end]

g = Graph.new

input.map { |e| e.split('-') }.each do |edge|
  g.add_edge(edge[0], edge[1])
  g.add_edge(edge[1], edge[0])
end

# g.print_all_edges

g.print_all_paths('start', 'end')
