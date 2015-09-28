class Wallet
  attr_accessor :money
  MONEY_SET = [10000, 5000, 1000, 500, 100, 50, 10, 5, 1]
  def initialize(one: 0, five: 0, ten: 0, fifty: 0, hundred: 0,
    five_hundred: 0, thousand: 0, five_thousand: 0, ten_thousand: 0)
    @money = {
      10000 => ten_thousand,
      5000  => five_thousand,
      1000  => thousand,
      500   => five_hundred,
      100   => hundred,
      50    => fifty,
      10    => ten,
      5     => five,
      1     => one
    }
  end

  def amount_yen
    @money.inject(0) {|sum, (yen, num)| sum + (yen * num)}
  end

  def amount_coins
    @money[1] + @money[5] + @money[10] + @money[50] + @money[100] + @money[500]
  end
  
  def deposit!(money)
    money.each { |yen, num| @money[yen] += num }
  end

  def withdraw!(money)
    money.each do |yen, num|
      exception("Over using money") if money[yen] > num
      @money[yen] -= num
    end
  end
end
