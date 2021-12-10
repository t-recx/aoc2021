#!/usr/bin/env ruby

points = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
points_completion = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }

pairs = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }

input = File.readlines(ARGV[0]).map(&:strip).map(&:chars)

corrupted_score = 0

completion_scores = []

input.each do |line|
  s = []

  corrupted = false

  line.each do |c|
    if pairs.keys.include? c
      s.push c
    elsif pairs[s.pop] != c
      corrupted_score += points[c]
      corrupted = true
      break
    end
  end

  next if corrupted

  completion_scores.push(
    s
    .reverse
    .map { |c| points_completion[c] }
    .reduce { |acc, v| acc * 5 + v }
  )
end

p corrupted_score

p completion_scores.sort[completion_scores.length / 2]
