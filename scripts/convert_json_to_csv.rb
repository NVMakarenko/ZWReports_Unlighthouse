require 'json'
require 'csv'

input_file = '.unlighthouse/dist/ci-result.json'
output_file = '.unlighthouse/dist/ci-result.csv'

begin
  json_data = JSON.parse(File.read(input_file))
  CSV.open(output_file, 'w', write_headers: true, headers: json_data.first.keys) do |csv|
    json_data.each do |row|
      csv << row.values
    end
  end
  puts "CSV file created successfully: #{output_file}"
rescue Errno::ENOENT
  puts "File not found: #{input_file}"
rescue JSON::ParserError => e
  puts "Error parsing JSON: #{e.message}"
end
