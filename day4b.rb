#!/usr/bin/env ruby

def get_score(board, number_called)
  number_called * board.flat_map { |_, v| v.map { |_, vv| vv } }
    .reject { |_, marked| marked }
    .map { |n, _| n }
    .sum 
end

def winner_found(board, number_called)
  5.times do |i|
    return [board, get_score(board, number_called)] if board[i]&.all? { |_, v| v[1] } || board.all? { |_, v| v[i][1] }
  end

  nil
end

input = File.readlines(ARGV[0]).map(&:strip)

drawn_numbers = input.first.split(',').map(&:to_i)

boards = {}

current_board = {}

numbers_boards = {}

z, y = 0, 0

input.drop(2).each do |line|
  if line.empty?
    y = 0

    boards[z] = current_board

    current_board = {}

    z += 1

    next
  end

  current_board[y] = {}

  line.split.map(&:to_i).each_with_index do |value, x|
    current_board[y][x] = [value, false]

    numbers_boards[value] = [] unless numbers_boards[value]
    numbers_boards[value].push [z, y, x]
  end

  y += 1
end

drawn_numbers.each do |number|
  next unless numbers_boards[number]

  numbers_boards[number].each do |bz, by, bx|
    boards[bz][by][bx][1] = true if boards[bz] && boards[bz][by]

    boards.each_value do |board|
      board, score = winner_found(board, number)

      if score
        boards = boards.reject { |_, v| v == board}

        return p(score) if boards.empty?
      end
    end
  end
end
