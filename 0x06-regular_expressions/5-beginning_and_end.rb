#!/usr/bin/env ruby
# Check if the first argument matches the regular expression pattern
if ARGV[0] =~ /^h.n$/
  puts ARGV[0].scan(/^h.n$/).join
else
  puts ""
end
