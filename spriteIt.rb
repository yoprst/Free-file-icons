#coding: utf-8
require "rubygems"


files = Dir["48px/*.png"]

puts files
images = []
files.each do |file|
  output = `identify #{file}`
  print output
  size = output.match(/\s(\d+)x(\d+)\s/)
  width = size[1]
  height = size[2]
  images << {:path => file, :width => width.to_i, :height => height.to_i}
end
css = ".icon.filetype {background: image-url('montage.png');display: inline-block;}\r\n"
current = 0
images.each do |image|
  css << ".icon.filetype.#{image[:path].match(/\/(.*)\.\S*/)[1]} {background-position: 0 -#{current}px; height:#{image[:height]}px; width:#{image[:width]}px}\r\n"
  current += image[:height]
end
system "montage -background transparent -tile 1x#{images.length} -geometry +0+0 #{images.map { |i| i[:path] }.join(' ')} montage.png"
File.open('test.css', 'w') { |file| file.write css }







