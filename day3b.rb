#!/usr/bin/env ruby

def get_value(a, pref)
  selected_number = ''

  return selected_number if a.first.empty?

  number_count = a.map { |x| x.chars[0] }.each_with_object(Hash.new(0)) { |val, hash| hash[val] += 1 }

  if number_count['0'] == number_count['1']
    selected_number = pref
  else
    selected_number = number_count.sort_by { |_, v| pref == '1' ? -v : v }.map { |k, _| k }.first
  end

  selected_number += get_value(a.select { |x| x[0] == selected_number }.map { |x| x[1..] }, pref)

  selected_number
end

input = File.readlines(ARGV[0]).map(&:strip)

p %w(0 1).map { |pref| get_value(input, pref).to_i(2) }.reduce(:*)
