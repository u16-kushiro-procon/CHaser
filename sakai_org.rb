# -*- coding: utf-8 -*-
# Filename sakai_org.rb
# Date 8.24.2013
# Author Nobuyuki SAKAI
# CHaserのSAKAIオリジナルクライアントプログラム  

require './CHaserConnect'

# 制御情報をチェック
def serverCheck
  if $values[0] == 0 # 対戦終了ならtrue
    return true
  else               # 対戦終了じゃないならfalse
    return false
  end
end

def coordinateCheck
  $values = $target.getReady
  if serverCheck
    return false
  end

  $values = $target.searchRight
  if serverCheck
    return false
  end

  $values = $target.getReady
  if serverCheck
    return false
  end

  $values = $target.searchUp
  if serverCheck
    return false
  end

  return true
end

# サーバに接続
$target = CHaserConnect.new("釧路", 2009, 'localhost')

$values = Array.new(10) # 配列の初期化
$maps = Array.new(17).map{Array.new(15,0)}
initial = true

loop do
  if initial
    if coordinateCheck == false
      break
    end
    $maps[$x][$y] = 4
  end
end