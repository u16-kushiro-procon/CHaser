# -*- coding: utf-8 -*-
# demo.rb 

require "./CHaserConnect.rb"

target = CHaserConnect.new("demo", 2009, 'localhost')

values = Array.new(10)
mode = 1

loop do
  values = target.getReady
  if values[0] == 0
    break
  end

  if values[2] == 1 || values[4] == 1 || values[6] == 1 || values[8] == 1
    mode = 90
  end

  if values[2] == 3 || values[4] == 3 || values[6] == 3 || values[8] == 3
    old_mode = mode
    mode = 20
  end

  if mode == 1
    if values[2] != 2           # 下が壁でないなら
      values = target.walkUp        # 下に進む
    else                        # 下が壁なら
      values = target.walkLeft  # 右に進む
      mode = 2
    end
  elsif mode == 2
    if values[4] != 2           # 右が壁でないなら
      values = target.walkLeft  # 右に進む
    else                        # 右が壁なら
      values = target.walkDown    # 上に進む
      mode = 3
    end
  elsif mode == 3
    if values[8] != 2           # 上が壁でないなら
      values = target.walkDown    # 上に進む
    else                        # 上が壁なら
      values = target.walkRight  # 左に進む
      mode = 4
    end
  elsif mode == 4
    if values[6] != 2           # 左が壁でないなら
      values = target.walkRight  # 左に進む
    else                        # 左が壁なら
      values = target.walkDown  # 下に進む
      mode = 1
    end
  elsif mode == 20
    if values[2] == 3
      values = target.walkUp
    elsif values[4] == 3
      values = target.walkLeft
    elsif values[6] == 3
      values = target.walkRight
    else
      values = target.walkDown
      mode = old_mode
    end
  elsif mode == 90
    if values[2] == 1
      values = target.putUp
    elsif values[4] == 1
      values = target.putLeft
    elsif values[6] == 1
      values = target.putRight
    else
      values = target.putDown
    end
  end

  if values[0] == 0
    break
  end
end   

target.close
