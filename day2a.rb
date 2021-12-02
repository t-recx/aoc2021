#!/usr/bin/env ruby

p (File.readlines(ARGV[0])
  .map(&:split)
  .map { |i, n| [i[0], n.to_i] }
  .map { |i, n| i == 'f' ? [n, 0] : (i == 'u' ? [0, -n] : [0, n]) }
  .reduce { |a, v| [a[0] + v[0], a[1] + v[1]] }
  .reduce(:*))
