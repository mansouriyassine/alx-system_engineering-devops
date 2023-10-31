#!/usr/bin/env ruby
# Reads a log file containing TextMe app text message transactions and extracts the sender, receiver,
# and flags information in the specified format: [SENDER],[RECEIVER],[FLAGS].
puts ARGV[0].scan(/\[(?:from:|to:|flags:)(.*?)\]/).join(",")
