# -*- coding: utf-8 -*-

=begin Test用プログラム
To使用版
=end

require './CHaserConnect.rb'

# サーバに接続
target = CHaserConnect.new("テスト4", 2009, 'localhost')

values = Array.new(10)

loop do

  values = target.getReady
  if values[0] == 0
    break
  end

  # 引数を"up"、0、CHaserConnect::UPで上
  values = target.searchTo(CHaserConnect::UP)
  if values[0] == 0
    break
  end


  values = target.getReady
  if values[0] == 0
    break
  end

  # 引数を"right"、3、CHaserConnect::RIGHTで右
  values = target.searchTo(CHaserConnect::RIGHT)
  if values[0] == 0
    break
  end

  values = target.getReady
  if values[0] == 0
    break
  end

  # 引数を"down"、1、CHaserConnect::DOWNで下
  values = target.searchTo(CHaserConnect::DOWN)
  if values[0] == 0
    break
  end

  values = target.getReady
  if values[0] == 0
    break
  end

  # 引数を"left"、2、CHaserConnect::LEFTで左
  values = target.searchTo(CHaserConnect::LEFT)
  if values[0] == 0
    break
  end
end 