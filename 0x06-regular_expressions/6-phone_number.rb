#!/usr/bin/env ruby
# Check if the first argument matches the regular expression pattern
if ARGV[0] =~ /^\d{10}$/
  puts ARGV[0].scan(/^\d{10}$/).join
else
  puts ""
end
