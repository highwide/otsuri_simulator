class Money
  attr_accessor :body

  VALUES = [10000, 5000, 1000, 500, 100, 50, 10, 5, 1]

  def initialize(one: 0, five: 0, ten: 0, fifty: 0, hundred: 0,
    five_hundred: 0, thousand: 0, five_thousand: 0, ten_thousand: 0)
    @body = {
      10000 => ten_thousand || 0,
      5000  => five_thousand || 0,
      1000  => thousand || 0,
      500   => five_hundred || 0,
      100   => hundred || 0,
      50    => fifty || 0,
      10    => ten || 0,
      5     => five || 0,
      1     => one || 0
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
                one: @body[1]     + mny.body[1],
               five: @body[5]     + mny.body[5],
                ten: @body[10]    + mny.body[10],
              fifty: @body[50]    + mny.body[50],
            hundred: @body[100]   + mny.body[100],
       five_hundred: @body[500]   + mny.body[500],
           thousand: @body[1000]  + mny.body[1000],
      five_thousand: @body[5000]  + mny.body[5000],
       ten_thousand: @body[10000] + mny.body[10000]
    )
  end

  def sub(mny)
    sub_mny = {
                one: @body[1]     - mny.body[1],
               five: @body[5]     - mny.body[5],
                ten: @body[10]    - mny.body[10],
              fifty: @body[50]    - mny.body[50],
            hundred: @body[100]   - mny.body[100],
       five_hundred: @body[500]   - mny.body[500],
           thousand: @body[1000]  - mny.body[1000],
      five_thousand: @body[5000]  - mny.body[5000],
       ten_thousand: @body[10000] - mny.body[10000]
    }

    raise "Over using money : @body: #{@body}, mny: #{mny}" if sub_mny.values.any? {|m| m < 0 }

    Money.new(sub_mny)
  end
end
