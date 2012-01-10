require 'bindata'
require './data_structure.rb'

class Parser
  def self.parse filename
    puts "Processing \"#{filename}\""
    if File.exist?(filename)
      if File.extname(filename) == '.ewscesm'
        puts "Found EIS file"
        self.parse_eis(filename)
      elsif File.extname(filename) == '.csv'
        puts "Found csv file"
        create_eis(filename)
      end
    else
      puts "File not found!"
    end
  end

  def self.parse_eis(input_filename)
    ## Read file into memory
    input_file = File.open(input_filename, 'rb')
    data = input_file.read
    input_file.close

    ## Parse data into format
    parsed_data = EISData.read(data)

    #puts "Header #{parsed_data.header1}, #{parsed_data.header2}"
    #puts "Library :-"
    #puts "freq max:#{parsed_data.library.freq_max}, min:#{parsed_data.library.freq_min}, code:#{parsed_data.library.freq_agility_code}"
    #puts "freq max:#{parsed_data.measured.freq_max}, min:#{parsed_data.measured.freq_min}, code:#{parsed_data.measured.freq_agility_code}"

    puts parsed_data.snapshot

    #puts "Header #{r.header1}, #{r.header2}"
    #puts "Library :-"
    #puts "freq max:#{r.library.freq_max}, min:#{r.library.freq_min}, code:#{r.library.freq_agility_code}"
    #puts "freq max:#{r.measured.freq_max}, min:#{r.measured.freq_min}, code:#{r.measured.freq_agility_code}"
    #pp r.snapshot

    ## debug
    #puts '-------------------------------'
    #BinData::trace_reading do
    #  EISData.read(data)
    #end

    ## Format for CSV
    reform = parsed_data.snapshot.to_s
    reform.gsub!('=>',',')
    reform.gsub!('{',"\n")
    reform.gsub!(', ',"\n")
    reform.gsub!('}',"\n")
    #puts reform # debug/info

    File.open(input_filename + '_out.csv', 'w') do |f|
      f.puts reform
    end
  end

  def create_eis(input_filename)
    ## Read file into memory
    input_file = File.open(input_filename, 'r')
    data = input_file.read
    input_file.close

    parsed_data = EISData.new
    #  data.each_line do |line|
    #    #line.gsub('/".*/"', "").to_label
    #    puts line
    #  end
    parsed_data.threat1.library.freq_max = data.find("freq_max");

    File.open(input_filename + '_out.ewscesm', 'wb') do |io|
      parsed_data.write(io)
    end
  end
end
