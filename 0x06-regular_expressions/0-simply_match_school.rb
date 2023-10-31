#!/usr/bin/env ruby
# Checks if the provided argument contains the word "School" and prints "School" if found or an empty line if not found.
if ARGV[0] =~ /School/
  puts ARGV[0].scan(/School/).join
else
  puts ""
end
