#!/usr/bin/env ruby
require 'bindata'
require 'pp'
require './data_structure.rb'

input_file = ARGV[0]
puts "Opening file... \"#{input_file}\""



## Read file into memory
io = File.open(input_file, 'rb')
data = io.read
io.close

## Parse data into format
r = EISData.read(data)

#puts "Header #{r.header1}, #{r.header2}"
#puts "Library :-"
#puts "freq max:#{r.library.freq_max}, min:#{r.library.freq_min}, code:#{r.library.freq_agility_code}"
#puts "freq max:#{r.measured.freq_max}, min:#{r.measured.freq_min}, code:#{r.measured.freq_agility_code}"

pp r.snapshot

