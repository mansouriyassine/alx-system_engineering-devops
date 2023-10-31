#!/usr/bin/env ruby
# Check if the first argument matches the regular expression pattern
if ARGV[0] =~ /hbt*n/
  puts ARGV[0].scan(/hbt*n/).join
else
  puts ""
end
