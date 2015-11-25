require './lib/wallet'
require './lib/money'

class Person
  attr_accessor :wallet, :coins_history

  def initialize
    @wallet = Wallet.new(
      one: 4,
      five: 1,
      ten: 4,
      fifty: 1,
      hundred: 4,
      five_hundred: 1,
      thousand: 4,
      five_thousand: 1,
      ten_thousand: 4
    ) # 49999円
    @coins_history = []
  end

  def decide
    # 継承先で定義する
  end

  def do_shopping
    while
      buying_price = rand(4000)
      break if buying_price > @wallet.amount_yen
      buy(buying_price)
      @coins_history << @wallet.amount_coins
    end
  end

  def buy(price)
    using_money = decide(price)
    @wallet.withdraw!(using_money)
    change = Money.smallest_new(using_money.amount_yen - price)
    @wallet.deposit!(change)
  end

  def average_having_coins
    @coins_history.inject(:+) / @coins_history.length
  end

  def pay_precisely? (price)
    Money::VALUES.each do |v|
      return true if price == 0
      return false if price < 0

      price -= (v * Wallet.money[v])
    end
  end
end
