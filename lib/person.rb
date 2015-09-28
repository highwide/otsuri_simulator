require './lib/wallet.rb'

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
    change = using_money.inject(0) {|sum, (yen, num)| sum + (yen * num)} - price
    recieve_change(change)
  end

  def recieve_change(price)
    change = {}
    Wallet::MONEY_SET.each do |m|
      count_money = price / m
      change[m] = count_money
      price -= count_money * m
      break if price == 0
    end
    @wallet.deposit!(change)
  end

  def average_having_coins
    @coins_history.inject {|sum, coins| sum + coins} / @coins_history.length
  end

  def pay_precisely(price)
    using_money = {}
    tmp_wallet = @wallet.money.sort{|a, b| a[0] <=> b[0]}.to_h
    Wallet::MONEY_SET.each do |m|
      count_money = price / m
      if count_money > 0
        tmp_wallet.each do |k, v|
          tmp_price = 0
          v.downto(1) do |i|
            if tmp_price == 0 && k * i == count_money * m
              using_money[k] = i
              tmp_price = count_money * m
              tmp_wallet.delete(k)
            end
          end
          price -= tmp_price
        end
      end
      break if price == 0
    end
    using_money.empty? ? false : using_money
  end
end
