#!/usr/bin/env ruby

pairs = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }

points_corruption = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
points_completion = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }

input = File.readlines(ARGV[0]).map(&:strip).map(&:chars)

corrupted_score = 0

completion_scores = []

input.each do |line|
  stack = []

  corrupted = false

  line.each do |c|
    if pairs.keys.include? c
      stack.push c
    elsif pairs[stack.pop] != c
      corrupted_score += points_corruption[c]
      corrupted = true
      break
    end
  end

  next if corrupted

  completion_scores.push(
    stack
    .reverse
    .map(&points_completion)
    .reduce { |acc, v| acc * 5 + v }
  )
end

p corrupted_score

p completion_scores.sort[completion_scores.length / 2]
