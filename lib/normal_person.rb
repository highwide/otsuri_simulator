require './lib/person.rb'

class NormalPerson < Person
  def decide(price)
    if pay_precisely?(price)
      precise_money(price)
    else
      tmp_money = round_money_ary(price).find {|p| pay_precisely? p}
      # 100の位以下->10の位->1の位と細かく出せないか探していく
      unit = [10000, 1000, 100, 10].find do |u|
        tmp_money % u == 0 && pay_precisely?((price % u) + tmp_money)
      end
      if unit.nil?
        precise_money(tmp_money)
      else
        precise_money((price % unit) + tmp_money)
      end
    end
  end
end
