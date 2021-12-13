# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 12 Part 2
# https://adventofcode.com/2021/day/12#part2
# Answer is: ???

class Graph
  def initialize(input)
    @adj_list = {}
    @all_paths = []

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
    @all_paths.length
  end

  def print_all_paths(s, d)
    generate_all_paths(s, d, print_paths: true)
  end

  def generate_all_paths(s, d, print_paths: false)
    is_visited = {}
    path_list = []
    @all_paths = []

    path_list << s

    # generate_all_paths_util(s, d, is_visited, '', path_list, print_paths)
    generate_all_paths_util(s, d, is_visited, path_list, print_paths)
  end

  private

  # def generate_all_paths_util(u, d, is_visited, double_visit, local_path_list, print_paths)
  def generate_all_paths_util(u, d, is_visited, local_path_list, print_paths)
    if u == d
      @all_paths << local_path_list.join(',')
      puts local_path_list.join(',') if print_paths
      return
    end

    # return if u == double_visit

    is_visited[u] = false
    is_visited[u] = true if u.split('').all? { |c| c == c.downcase }

    # is_visited[u] = 0 unless is_visited.keys.include?(u)
    # is_visited[u] = 1 if %w[start end].include?(u)
    # is_visited[u] += 1 if u.split('').all? { |c| c == c.downcase } && !%w[start end].include?(u)

    @adj_list[u].each do |i|
      # if is_visited[i] && double_visit == '' && i.split('').all? { |c| c == c.downcase } && !%w[start end].include?(i)
      #   double_visit = i
      # end

      puts "#{u} -> #{d}, #{i}, #{is_visited}"
      gets

      # next if is_visited[i] && double_visit != i
      next if is_visited[i]

      local_path_list << i
      puts "BEFORE #{local_path_list}"
      # generate_all_paths_util(i, d, is_visited, double_visit, local_path_list, print_paths)
      generate_all_paths_util(i, d, is_visited, local_path_list, print_paths)
      local_path_list.pop
      puts "AFTER #{local_path_list}"
    end

    is_visited[u] = false
  end
end

input = %w[start-A start-b A-c A-b b-d A-end b-end]
# input = %w[dc-end HN-start start-kj dc-start dc-HN LN-dc HN-end kj-sa kj-HN kj-dc]
# input = %w[fs-end he-DX fs-he start-DX pj-DX end-zg zg-sl zg-pj pj-he RW-he fs-DX
#            pj-RW zg-RW start-pj he-WI zg-he pj-fs start-RW]
# input = %w[start-YA ps-yq zt-mu JS-yi yq-VJ QT-ps start-yq YA-yi start-nf nf-YA nf-JS
#            JS-ez yq-JS ps-JS ps-yi yq-nf QT-yi end-QT nf-yi zt-QT end-ez yq-YA end-JS]

g = Graph.new(input)

g.print_all_paths('start', 'end')
