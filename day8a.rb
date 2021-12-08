#!/usr/bin/env ruby

p(File
  .readlines(ARGV[0])
  .map(&:strip)
  .map { |x| x.split(' | ') }
  .map { |_, b| b.split }
  .flat_map { |x| x.map(&:length) }
  .count { |x| ![5, 6].include?(x) })
