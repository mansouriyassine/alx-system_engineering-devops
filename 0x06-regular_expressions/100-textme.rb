#!/usr/bin/env ruby
#  reads a log file containing TextMe app text message transactions and extracts the sender, receiver,
#  and flags information in the specified format: [SENDER],[RECEIVER],[FLAGS].
if ARGV.empty?
  puts "Usage: #{$PROGRAM_NAME} <log_file>"
  exit(1)
end

log_file = ARGV[0]

File.open(log_file, 'r').each do |line|
  sender = line.match(/\[from:([^]]+)\]/)
  receiver = line.match(/\[to:([^]]+)\]/)
  flags = line.match(/\[flags:([^]]+)\]/)

  if sender && receiver && flags
    puts "#{sender[1]},#{receiver[1]},#{flags[1]}"
  end
end
