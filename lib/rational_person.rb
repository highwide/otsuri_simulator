require './lib/person.rb'

class RationalPerson < Person
  def decide(price)
    if pay_precisely(price)
      pay_precisely(price)
    else
      rational_pay(price)
    end
  end

  def rational_pay(price)
    using_money = {}
    tmp_wallet = @wallet.money.sort{|a, b| a[0] <=> b[0]}.to_h
    [1000, 100, 10].each do |m|
      tmp_money = price / m
      if tmp_money > 0
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
  end

  private

  def has_?(price)
end
