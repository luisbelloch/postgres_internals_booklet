#!/usr/bin/ruby

require 'rubygems'
require 'RedCloth'

token = '<!-- CONTENT -->'
template = File.read('template.html')

content = ''
Dir.glob('*.textile') do |f|
  content << RedCloth.new(File.read(f)).to_html
end

output = template.gsub(token, content)
File.open('postgres_internals.html', 'w') { |f| f.write(output) }
