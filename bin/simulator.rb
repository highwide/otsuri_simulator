require 'bundler'
Bundler.require

require './lib/lazy_person.rb'

ave = []
10000.times do 
  person = LazyPerson.new
  person.do_shopping
  ave << person.coins_history.inject{|sum, item| sum + item}.to_f / person.coins_history.length.to_f
end

puts ""
puts "平均: #{ave.inject{|sum, item| sum + item}.to_f / ave.length.to_f}枚の硬貨"
