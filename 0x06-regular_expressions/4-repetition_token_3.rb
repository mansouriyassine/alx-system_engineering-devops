#!/usr/bin/env ruby
# Check if the first argument matches the regular expression pattern
if ARGV[0] =~ /hb*t{1,4}n/
  puts ARGV[0].scan(/hb*t{1,4}n/).join
else
  puts ""
end
