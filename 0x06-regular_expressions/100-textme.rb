#!/usr/bin/env ruby
# Reads a log file containing TextMe app text message transactions and extracts the sender, receiver,
# and flags information in the specified format: [SENDER],[RECEIVER],[FLAGS].
if ARGV.empty?
  puts "Usage: #{$PROGRAM_NAME} <log_file>"
  exit(1)
end

log_file = ARGV[0]

File.open(log_file, 'r').each do |line|
  data = line.scan(/\[(?:from:|to:|flags:)(.*?)\]/)
  if data.length == 3
    puts data.join(",")
  end
end
