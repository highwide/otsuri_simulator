require './lib/money'

class Wallet
  attr_accessor :money

  def initialize(one: 0, five: 0, ten: 0, fifty: 0, hundred: 0,
    five_hundred: 0, thousand: 0, five_thousand: 0, ten_thousand: 0)
    @money = Money.new(
                one: one,
               five: five,
                ten: ten,
              fifty: fifty,
            hundred: hundred,
       five_hundred: five_hundred,
           thousand: thousand,
      five_thousand: five_thousand,
       ten_thousand: ten_thousand
    )
  end

  def amount_yen
    @money.amount_yen
  end

  def amount_coins
    @money.amount_coins
  end
  
  def deposit!(mny)
    @money = @money.add mny
  end

  def withdraw!(mny)
    @money = @money.sub mny
  end
end
