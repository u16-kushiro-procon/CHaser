# -*- coding: utf-8 -*-
# demo2.rb

require "./CHaserConnect.rb"

target = CHaserConnect.new("デモ2", 2009, 'localhost')

values = Array.new(10)
mode = 1
mode_old = 1

# mode
# 1  walkUp
# 2  walkDown
# 3  walkRight
# 4  walkLeft
# 5  putUp
# 6  putDown
# 7  putRight
# 8  putLeft
# 9  lookUp
# 10 lookDown
# 11 lookRight
# 12 lookLeft
# 13 searchUp
# 14 searchDown
# 15 searchRight
# 16 searchLeft

loop do
  values = target.getReady
  if values[0] == 0
    break
  end

  if mode_old == 1
    if values[2] != 2
      mode = 1
    else
      mode = 4
    end
  end

  if mode_old == 4 || mode == 4
    if values[4] != 2
      mode = 4
    else
      mode = 2
    end
  end

  if mode_old == 2 || mode == 2
    if values[8] != 2
      mode = 2
    else
      mode = 3
    end
  end

  if mode_old == 3 || mode == 3
    if values[6] != 2
      mode = 3
    else
      mode = 1
    end
  end

  if values[2] == 3 || values[4] == 3 || values[6] == 3 || values[8] == 3
    if values[2] == 3
      mode = 1
    elsif values[4] == 3
      mode = 4
    elsif values[6] == 3
      mode = 3
    else
      mode = 2
    end
  end

  if values[2] == 1 || values[4] == 1 || values[6] == 1 || values[8] == 1
    if values[2] == 1
      mode = 5
    elsif values[4] == 1
      mode = 8
    elsif values[6] == 1
      mode = 7
    else
      mode = 6
    end
  end    

  if mode == 1
    values = target.walkUp
  elsif mode == 2
    values = target.walkDown
  elsif mode == 3
    values = target.walkRight
  elsif mode == 4
    values = target.walkLeft
  elsif mode == 5
    values = target.putUp
  elsif mode == 6
    values = target.putDown
  elsif mode == 7
    values = target.putRight
  elsif mode == 8
    values = target.putLeft
  end

  if values[0] == 0
    break
  end
  
  mode_old = mode       
end
