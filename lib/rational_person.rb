require './lib/person.rb'

class RationalPerson < Person
  def decide(price)
    if pay_precisely?(price)
      precise_money(price)
    else
      decide(price + 1)
    end
  end
end
