require './lib/person.rb'

class RationalPerson < Person
  def decide(price)
    if pay_precisely?(price)
      precise_money(price)
    else
      pay_money = Money.new
      tmp_wallet_money = @wallet.money

      # ex: 3,456 -> [6, 5, 4, 3]
      split_price = price.to_s.split('').map(&:to_i).reverse

      split_price.each_with_index do |n, i|
        if split_price.length == i + 1
          pay = round_money_ary(n * (10 ** i)).find {|v| pay_precisely? v}
          pay = precise_money(pay, tmp_wallet_money)
          tmp_wallet_money = tmp_wallet_money.sub pay
          pay_money = pay_money.add pay
        else
          if pay_precisely?(n * (10 ** i), tmp_wallet_money)
            pay = precise_money(n * (10 ** i), tmp_wallet_money)
            tmp_wallet_money = tmp_wallet_money.sub pay
            pay_money = pay_money.add pay
          elsif pay_precisely?((n % 5) * (10 ** i), tmp_wallet_money)
            split_price = kuriagari(split_price, i)

            pay = precise_money((n % 5) * (10 ** i), tmp_wallet_money)
            tmp_wallet_money = tmp_wallet_money.sub pay
            pay_money = pay_money.add pay
          elsif n < 5 && pay_precisely?(5 * (10 ** i), tmp_wallet_money)
            pay = precise_money(5 * (10 ** i), tmp_wallet_money)
            tmp_wallet_money = tmp_wallet_money.sub pay
            pay_money = pay_money.add pay
          elsif !(n == 0)
            split_price = kuriagari(split_price, i)
          end
        end
      end
      pay_money
    end
  end

  private

  def kuriagari(ary, i)
    ary[i + 1] = (ary[i + 1] || 0) + 1
    if ary[i + 1] == 10
      ary[i + 1] = 0
      kuriagari(ary, (i + 1))
    end
    ary
  end
end
