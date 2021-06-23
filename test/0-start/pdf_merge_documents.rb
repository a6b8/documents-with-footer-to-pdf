puts 
puts "MERGE PDF"
puts "----------------------------"
puts ""
puts "SET FOLDER "
print ">>  "

path = gets.chomp
path[ path.length-1, path.length-1 ].index( '/' ).nil? ? path = path + '/' : ''

output = ''
output += path
output += 'result.pdf'

files = Dir[ path + '*' ].sort!

require 'combine_pdf'
pdf = CombinePDF.new
files.each do | p |
  pdf << CombinePDF.load( p )
end

pdf.save( output )