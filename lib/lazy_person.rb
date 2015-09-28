require './lib/person.rb'

class LazyPerson < Person
  def decide(price)
    if pay_precisely(price)
      pay_precisely(price)
    else
      using_money = {}
      @wallet.money.each do |yen, num|
        using_money[yen] = num
        if using_money.inject(0) {|sum, (yen, num)| sum + (yen * num)} > price
          return using_money
        end
      end
    end
  end
end
