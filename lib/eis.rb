#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require './parser.rb'

# allow command line options
# -f<format> : output format (.csv/.yaml/.html/?)
# -p<field> : print fields (pass in name of field, do a eval on it and print its value)
# -s<field=value> : set field to value (as above but assign)
# -h : help

def help
  puts "#{$0} - parses EIS binary formatted files"
end

if ARGV[0].nil?
  puts "No input file(s) given!"
  help
  exit
end

ARGV.each { |f| Parser.parse(f) }
