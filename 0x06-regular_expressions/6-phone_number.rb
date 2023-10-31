#!/usr/bin/env ruby
# checks if the provided argument is a 10-digit phone number.
if ARGV[0] =~ /^[0-9]{10}$/
  puts ARGV[0].scan(/^[0-9]{10}$/).join
else
  puts ""
end
