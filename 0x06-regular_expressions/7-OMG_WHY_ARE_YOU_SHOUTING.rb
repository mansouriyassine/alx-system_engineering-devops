#!/usr/bin/env ruby
#  checks if the provided argument contains capital letters and prints them.
if ARGV[0] =~ /[A-Z]/
  puts ARGV[0].scan(/[A-Z]/).join
else
  puts ""
end
