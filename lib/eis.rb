#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require './parser.rb'

if ARGV[0].nil?
  puts "No input file(s) given!"
  exit
end

ARGV.each { |f| Parser.parse(f) }
