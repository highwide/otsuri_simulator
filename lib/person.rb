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

  # ピッタリ払うお金の組み合わせ
  def precise_money(price)
    init_ary = []
    Money::VALUES.reverse.each do |v|
      break if price == 0
      tmp = price / v
      init_ary[v] = [tmp, @wallet.money.body[v]].min
      price -= init_ary[v] * v
    end

    Money.new(
                one: init_ary[1],
               five: init_ary[5],
                ten: init_ary[10],
              fifty: init_ary[50],
            hundred: init_ary[100],
       five_hundred: init_ary[500],
           thousand: init_ary[1000],
      five_thousand: init_ary[5000],
       ten_thousand: init_ary[10000]
    )
  end

  # 手持ちでピッタリ払えるか？
  def pay_precisely?(price)
    Money::VALUES.reverse.each do |v|
      return true if price == 0
      tmp = price / v || binding.pry
      price -= [tmp, @wallet.money.body[v]].min * v
    end
    !!(price == 0)
  end

  # ピッタリ払えないときにお金ごとに切り上げる
  # ex: 8484円 -> 8485円 -> 8490円 -> 8500円 -> 9000円 -> 10000円
  def round_money_ary(price)
    [5, 10, 50, 100, 500, 1000, 5000, 10000].map do |v|
      if price % v == 0
        price
      else
        (price / v) * v + v
      end
    end
  end
end
