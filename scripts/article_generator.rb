require 'date'
file_name = File.expand_path('../../articles', __FILE__) + "/#{Time.now.to_i}.md"
File.open(file_name, "w") do |f|
  f.write "title:\nauthor: radi\ndate: #{Date.today.to_s}\n\n"
end