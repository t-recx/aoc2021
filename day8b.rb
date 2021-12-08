#!/usr/bin/env ruby

def get_output_values(signal_patterns, output_values)
  one = signal_patterns.select { |x| x.size == 2 }.first
  four = signal_patterns.select { |x| x.size == 4 }.first
  seven = signal_patterns.select { |x| x.size == 3 }.first
  eight = signal_patterns.select { |x| x.size == 7 }.first
  nine = signal_patterns.select { |x| x.size == 6 && four.chars.all? { |c| x.include?(c) } }.first

  a = signal_patterns.select { one.chars - seven.chars }.first[0]
  g = nine.chars.select { |c| four.include?(c) && seven.include?(c) }.first
  e = (eight.chars - nine.chars).first

  two = signal_patterns.select { |x| x.size == 5 && x.include?(e) }.first

  b = (four.chars - two.chars - one.chars).first

  five = signal_patterns.select { |x| x.size == 5 && x.include?(b) }.first
  three = signal_patterns.select { |x| x.size == 5 && x != five && x != two }.first

  d = (seven.chars - five.chars).first

  six = signal_patterns.select { |x| x.size == 6 && eight.chars - x.chars == [d] }.first
  zero = signal_patterns.select { |x| x.size == 6 && x != six && x != nine }.first

  definitions = { zero => 0, one => 1, two => 2, three => 3, four => 4, five => 5, six => 6, seven => 7, eight => 8, nine => 9 }

  output_values.map { |ov| definitions[ov] }.join.to_i
end

p(File
  .readlines(ARGV[0])
  .map(&:strip)
  .map { |x| x.split(' | ') }
  .map { |a, b| [a.split.map { |aa| aa.chars.sort.join }, b.split.map { |aa| aa.chars.sort.join }] }
  .map { |sp, ov| get_output_values(sp, ov) }
  .sum)
