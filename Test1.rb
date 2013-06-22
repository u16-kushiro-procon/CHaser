# -*- coding: utf-8 -*-

require './CHaserConnect.rb'
#require 'socket'

target = CHaserConnect.new("", 'localhost', ARGV[0])
values = Array.new(10)

loop do
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.searchUp
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.searchRight
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.searchDown
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.searchLeft
  if values[0] == 0
    break
  end
end

target.close