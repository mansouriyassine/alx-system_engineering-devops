#!/usr/bin/env ruby
# Check if the first argument matches the regular expression pattern
if ARGV[0] =~ /hb{0,1}tn/
  puts ARGV[0].scan(/hb{0,1}tn/).join
else
  puts ""
end
