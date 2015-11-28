require './lib/person.rb'

class LazyPerson < Person
  def decide(price)
    if pay_precisely?(price)
      precise_money(price)
    else
      pay_money = round_money_ary(price).find {|p| pay_precisely? p}
      precise_money(pay_money)
    end
  end
end
