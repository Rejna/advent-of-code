# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 12 Part 2
# https://adventofcode.com/2021/day/12#part2
# Answer is: 118242

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

  def count_all_paths(s, d, allow_multi_visits)
    generate_all_paths(s, d, allow_multi_visits)
    @all_paths
  end

  def generate_all_paths(s, d, allow_multi_visits)
    is_visited = {}
    path_list = []
    @all_paths = 0

    path_list << s

    generate_all_paths_util(s, d, is_visited, allow_multi_visits, '', path_list)
  end

  private

  def generate_all_paths_util(u, d, is_visited, allow_multi_visits, c2v, local_path_list)
    if u == d
      @all_paths += 1
      return
    end

    is_visited[u] = u == u.downcase

    @adj_list[u].each do |i|
      if is_visited[i]
        next unless allow_multi_visits && c2v == '' && i != 'start'

        c2v = i
      end

      local_path_list << i
      generate_all_paths_util(i, d, is_visited, allow_multi_visits, c2v, local_path_list)
      local_path_list.pop

      c2v = '' if c2v == i
    end

    is_visited[u] = false if u != c2v
  end
end

# input = %w[start-A start-b A-c A-b b-d A-end b-end]
# input = %w[dc-end HN-start start-kj dc-start dc-HN LN-dc HN-end kj-sa kj-HN kj-dc]
# input = %w[fs-end he-DX fs-he start-DX pj-DX end-zg zg-sl zg-pj pj-he RW-he fs-DX
#            pj-RW zg-RW start-pj he-WI zg-he pj-fs start-RW]
input = File.readlines('../1 Input/day12.input').map(&:strip)

g = Graph.new(input)

puts g.count_all_paths('start', 'end', false)
puts g.count_all_paths('start', 'end', true)
