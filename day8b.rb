#!/usr/bin/env ruby

def get_output_values(signal_patterns, output_values)
  one = signal_patterns.find { |x| x.size == 2 }
  four = signal_patterns.find { |x| x.size == 4 }
  seven = signal_patterns.find { |x| x.size == 3 }
  eight = signal_patterns.find { |x| x.size == 7 }
  nine = signal_patterns.find { |x| x.size == 6 && four.chars.all? { |c| x.include?(c) } }

  e = (eight.chars - nine.chars).first

  two = signal_patterns.find { |x| x.size == 5 && x.include?(e) }

  b = (four.chars - two.chars - one.chars).first

  five = signal_patterns.find { |x| x.size == 5 && x.include?(b) }
  three = signal_patterns.find { |x| x.size == 5 && x != five && x != two }

  d = (seven.chars - five.chars).first

  six = signal_patterns.find { |x| x.size == 6 && eight.chars - x.chars == [d] }
  zero = signal_patterns.find { |x| x.size == 6 && x != six && x != nine }

  definitions = [zero, one, two, three, four, five, six, seven, eight, nine].each_with_index.to_h

  output_values.map { |ov| definitions[ov] }.join.to_i
end

p(File
  .readlines(ARGV[0])
  .map { |x| x.split(' | ') }
  .map { |x| x.map { |y| y.split.map { |z| z.chars.sort.join } } }
  .sum { |sp, ov| get_output_values(sp, ov) })
