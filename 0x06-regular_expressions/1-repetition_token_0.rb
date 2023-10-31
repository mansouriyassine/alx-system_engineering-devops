#!/usr/bin/env ruby
# Check if the first argument matches the regular expression pattern
if ARGV[0] =~ /hbt{2,5}n/
  puts ARGV[0].scan(/hbt{2,5}n/).join
else
  puts ""
end
