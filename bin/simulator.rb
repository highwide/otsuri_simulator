require 'bundler'
Bundler.require

require './lib/lazy_person.rb'
require './lib/normal_person.rb'
require './lib/rational_person.rb'

def simulate_person(character)
  ave = []

  1000.times do 
    case character
    when "lazy"
      person = LazyPerson.new
    when "normal"
      person = NormalPerson.new
    when "rational"
      person = RationalPerson.new
    end

    person.do_shopping
    ave << person.coins_history.inject(:+).to_f / person.coins_history.length.to_f
  end

  puts "\n#{character}の平均: #{ave.inject(:+).to_f / ave.length.to_f}枚の硬貨"
end

simulate_person "lazy"
simulate_person "normal"
# simulate_person "rational"
