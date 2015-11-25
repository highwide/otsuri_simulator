class Money
  attr_accessor :body

  VALUES = [10000, 5000, 1000, 500, 100, 50, 10, 5, 1]

  def initialize(one: 0, five: 0, ten: 0, fifty: 0, hundred: 0,
    five_hundred: 0, thousand: 0, five_thousand: 0, ten_thousand: 0)
    @body = {
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

  def self.smallest_new(price)
    init_ary = []
    VALUES.each do |v|
      break if price == 0

      tmp = price / v
      init_ary[v] = tmp
      price -= (tmp * v)
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

  def amount_yen
    @body.inject(0) {|sum, (yen, num)| sum + (yen * num)}
  end

  def amount_coins
    [1, 5, 10, 50, 100, 500].map {|i| @body[i] }.inject(:+)
  end

  def add(mny)
    Money.new(
                one: @money[1]     + mny[1],
               five: @money[5]     + mny[5],
                ten: @money[10]    + mny[10],
              fifty: @money[50]    + mny[50],
            hundred: @money[100]   + mny[100],
       five_hundred: @money[500]   + mny[500],
           thousand: @money[1000]  + mny[1000],
      five_thousand: @money[5000]  + mny[5000],
       ten_thousand: @money[10000] + mny[10000]
    )
  end

  def sub(mny)
    sub_mny = {
                one: @money[1]     - mny[1],
               five: @money[5]     - mny[5],
                ten: @money[10]    - mny[10],
              fifty: @money[50]    - mny[50],
            hundred: @money[100]   - mny[100],
       five_hundred: @money[500]   - mny[500],
           thousand: @money[1000]  - mny[1000],
      five_thousand: @money[5000]  - mny[5000],
       ten_thousand: @money[10000] - mny[10000]
    }

    exception("Over using money") if sub_mny.values.any? {|m| m < 0 }

    Money.new(sub_mny)
  end
end
