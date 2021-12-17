# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 12 Part 1
# https://adventofcode.com/2021/day/12
# Answer is: 4304

class Graph
  def initialize(input)
    @adj_list = {}
    @all_paths = 0

    input.map { |e| e.split('-') }.each do |edge|
      add_edge(edge[0], edge[1])
      add_edge(edge[1], edge[0])
    end
  end

  def add_edge(u, v)
    @adj_list[u] << v if @adj_list.keys.include?(u)
    @adj_list[u] = [v] unless @adj_list.keys.include?(u)
  end

  def count_all_paths(s, d)
    generate_all_paths(s, d)
    @all_paths
  end

  def print_all_paths(s, d)
    generate_all_paths(s, d, print_paths: true)
  end

  def generate_all_paths(s, d, print_paths: false)
    is_visited = {}
    path_list = []
    @all_paths = 0

    path_list << s

    generate_all_paths_util(s, d, is_visited, path_list, print_paths)
  end

  private

  def generate_all_paths_util(u, d, is_visited, local_path_list, print_paths)
    if u == d
      @all_paths += 1
      puts local_path_list.join(',') if print_paths
      return
    end

    is_visited[u] = false
    is_visited[u] = true if u.split('').all? { |c| c == c.downcase }

    @adj_list[u].each do |i|
      next if is_visited[i]

      local_path_list << i
      generate_all_paths_util(i, d, is_visited, local_path_list, print_paths)
      local_path_list.pop
    end

    is_visited[u] = false
  end
end

# input = %w[start-A start-b A-c A-b b-d A-end b-end]
# input = %w[dc-end HN-start start-kj dc-start dc-HN LN-dc HN-end kj-sa kj-HN kj-dc]
# input = %w[fs-end he-DX fs-he start-DX pj-DX end-zg zg-sl zg-pj pj-he RW-he fs-DX
#            pj-RW zg-RW start-pj he-WI zg-he pj-fs start-RW]
input = File.readlines('../1 Input/day12.input').map(&:strip)

g = Graph.new(input)

# g.print_all_paths('start', 'end')
puts g.count_all_paths('start', 'end')
