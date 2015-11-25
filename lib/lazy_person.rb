require './lib/person.rb'

class LazyPerson < Person
  def decide(price)
    if pay_precisely?(price)
      precise_money(price)
    else
      tmp = [5, 10, 50, 100, 1000, 5000, 10000].find do |v|
        if !(price % v == 0)
          pay_precisely?((price / v) * v + v)
        else
          pay_precisely?(price)
        end
      end

      if !(price % tmp == 0)
        precise_money((price / tmp) * tmp + tmp)
      else
        precise_money(price)
      end
    end
  end
end
