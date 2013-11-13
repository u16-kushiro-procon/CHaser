#!/usr/bin/env ruby
# -*- coding utf-8 -*-

class QLearning
  def initialize
    @state = Array.new(10)
    @Q = 
  end

  def reset
    (0..@state.length-1).each do |i|
        @state[i] = rand(4)
    end
  end

  def walkUp
    @state[7] = @state[4]
    @state[8] = @state[5]
    @state[9] = @state[6]
    @state[4] = @state[1]
    @state[5] = @state[2]
    @state[6] = @state[3]
    (1..3).each do |i|
      @state[i] = rand(4)
    end
  end
end
