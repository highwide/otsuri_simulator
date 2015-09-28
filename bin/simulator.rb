require 'bundler'
Bundler.require

require './lib/lazy_person.rb'

person = LazyPerson.new
binding.pry
