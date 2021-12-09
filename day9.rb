#!/usr/bin/env ruby

@directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

def get_low_point(board, x, y)
  @directions.each do |dy, dx|
    next unless board[dy + y] && board[dy + y][dx + x]

    return nil if board[y][x] >= board[dy + y][dx + x]
  end

  [y, x]
end

def get_basin_size(board, x, y, visited)
  return 0 if visited[y] && visited[y][x]

  visited[y] = {} unless visited[y]
  visited[y][x] = true

  size = board[y][x] < 9 ? 1 : 0

  if size.positive?
    @directions.each do |dy, dx|
      next unless board[dy + y] && board[dy + y][dx + x]

      size += get_basin_size(board, dx + x, dy + y, visited)
    end
  end

  size
end

input = File.readlines(ARGV[0]).map(&:strip).map { |line| line.chars.map(&:to_i) }

input_board = {}

width = input.first.length
height = input.length

height.times do |y|
  input_board[y] = {}

  width.times do |x|
    input_board[y][x] = input[y][x]
  end
end

low_points = height
  .times
  .flat_map { |y| width.times.map { |x| get_low_point(input_board, x, y) } }
  .reject(&:nil?)

# part 1
p low_points.map { |y, x| input_board[y][x] + 1 }.sum

# part 2
p low_points
  .map { |y, x| get_basin_size(input_board, x, y, {}) }
  .sort_by(&:-@)
  .take(3)
  .reduce(:*)
