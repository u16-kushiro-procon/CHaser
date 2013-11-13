# -*- coding: utf-8 -*-
# sakai_demo.rb
# Date 8.31.2013
# Author Nobuyuki Sakai


require "./CHaserConnect.rb"

# 外枠かチェック(search専用)
def wallCheck(values)
  flg = false
  index = 0
  for i in 1..9
    if values[i] == 2 # i番目が壁なら
      if flg == false # flgがfalseなら
        flg = true # flgをtrueにする
        index = i # indexをiにする
      end
    else # 壁じゃなければ
      if flg # flgがtrueなら
        flg = false # flgをfalseにする
        index = 0 # indexを0に
      end
    end
  end

  return index
end

def coordinateCheck
  index = 0

  $values = $target.getReady
  if $values[0] == 0
    return false
  end

  $values = $target.searchUp
  if $values[0] == 0
    return false
  end
  if (index = wallCheck($values)) != 0
    $y = index - 1
  end


  $values = $target.getReady
  if $values[0] == 0
    return false
  end

  $values = $target.searchRight
  if $values[0] == 0
    return false
  end
  if (index = wallCheck($values)) != 0
    $x = $width - index
  end

  $values = $target.getReady
  if $values[0] == 0
    return false
  end

  $values = $target.searchDown
  if $values[0] == 0
    return false
  end
  if (index = wallCheck($values)) != 0
    $y = $height - index
  end

  $values = $target.getReady
  if $values[0] == 0
    return false
  end

  $values = $target.searchLeft
  if $values[0] == 0
    return false
  end
  if (index = wallCheck($values)) != 0
    $x = index - 1
  end

  return true
end

def rangeCheck(x, y)
  if x < 0
    return false
  end
  if x >= width
    return false
  end
  if y < 0
    return false
  end
  if y >= height
    return false
  end

  return true
end

def surround(values) # look,search以外の周囲情報からマップを作成    
  idx = 1
  for i in -1..1
    for j in -1..1
      if rangeCheck($x+i, $y+j)
        $maps[$x+i][$y+j] = values[idx]
      end
      idx += 1
    end
  end
end

def walkUp
  $values = $target.walkUp
  $y -= 1
  states[$x][$y] = true
end

def walkDown
  $values = $target.walkDown
  $y += 1
  states[$x][$y] = true
end

def walkRight
  $values = $target.walkRight
  $x += 1
  states[$x][$y] = true
end

def walkLeft
  $values = $target.walkLeft
  $x -= 1
  states[$x][$y] = true
end

# 周囲情報からブロックである番号を配列で返す
def wallArray(values)
  tmp = Array.new 
  values.each_with_index do |item, idx|
    if item == 2
      tmp.push(idx)
    end
  end

  return tmp
end


$target = CHaserConnect.new("芽室", 2009, 'localhost')

$values = Array.new(10)
$maps = Array.new(15).map{Array.new(17, 9)}
$states = Array.new(15).map{Array.new(17, false)}
$y = -1
$x = -1
$width = 15
$height = 17
initial = true

loop do
  if initial
    if coordinateCheck == false
      break
    end
    initial = false
    $states[$x][$y] = true
  end

  print "#{$x} #{$y}\n"



end

$target.close