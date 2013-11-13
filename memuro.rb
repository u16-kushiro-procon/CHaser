# -*-coding: utf-8 -*-

# memuro.rb
# Author:: Nobuyuki SAKAI
# Date:: 10/04/2013

require './CHaserConnect.rb'

# 定数
# UP     = 0
# DOWN   = 1
# LEFT   = 2
# RIGHT  = 3
# WALK   = 0
# SEARCH = 1
# LOOK   = 2
# PUT    = 3

class CHaserMemuro
  # インスタンス
  # Param:: name(名前), port(ポート), host(IPアドレス,ホスト名)
  def initialize(name, port, host = 'localhost', height: 17, width: 15)
    @port   = port
    @target = CHaserConnect.new(name, port, host)
    @values = Array.new(10) # 制御情報と周囲情報
    @maps   = Array.new(height).map{Array.new(width, 0)} # マップ作成用
  end

  # サーバが終了しているかチェック
  # Return:: boolean
  def exit?
    if @values[0] == 0
      return true
    else
      return false
    end
  end

  # 2次元配列の生成  
  def init_array(height, width)
    tmp = Array.new(height)
    (0..tmp.size-1).each do |i|
      tmp = Array.new(width, 0)
    end

    return tmp
  end

  # 周囲にあるアイテム数をカウントする
  # Return:: item_count(アイテム数)
  def count_item
    item_count = 0

    @values.each do |item|
      if item == 3
        item_count += 1
      end
    end

    return item_count
  end

  # 敵がいるかチェックし居場所を返すメソッド
  # Return:: index
  def check_enemy
    @values.each_with_index do |item, index|
      if index == 0
        next
      end

      if item == 1
        return index
      end
    end

    return false
  end

  # 四方のブロックをチェックしてブロックじゃない方向の配列を返す
  # Return:: no_blocks(プロックじゃないリスト)
  def check_block
    no_blocks = Array.new
    if @values[2] != 2
      no_blocks.push(CHaserConnect::UP)
    end
    if @values[4] != 2
      no_blocks.push(CHaserConnect::LEFT)
    end
    if @values[6] != 2
      no_blocks.push(CHaserConnect::RIGHT)
    end
    if @values[8] != 2
      no_blocks.push(CHaserConnect::DOWN)
    end

    return no_blocks
  end


  # 最初のコマンド。2方向のアイテム数に応じて移動方向を決定する。  
  # Return:: direction(方向), false
  def first_command
    item_counts = Array.new(2)
    @values = @target.getReady
    if @values[0] == 0
      return false
    end

    #先攻なら右と下にsearch、後攻なら左と右にsearch
    if @port == 2009 || @port == 40000
      @values = @target.command(CHaserConnect::SEARCH, CHaserConnect::RIGHT)
      item_counts[0] = count_item()
      if @values[0] == 0
        return false
      end

      @values = @target.getReady
      if @values[0] == 0
        return false
      end

      @values = @target.command(CHaserConnect::SEARCH, CHaserConnect::DOWN)
      item_counts[1] = count_item()
      if @values[0] == 0
        return false
      end

      if item_counts[0] > item_counts[1]
        direction = CHaserConnect::RIGHT
      elsif item_counts[0] < item_counts[1]
        direction = CHaserConnect::DOWN
      else
        directions = [CHaserConnect::RIGHT, CHaserConnect::DOWN]
        direction = directions[rand(directions.size)]
      end
    elsif @port == 2010 || @port == 50000
      @values = @target.command(CHaserConnect::SEARCH, CHaserConnect::LEFT)
      item_counts[0] = count_item()
      if @values[0] == 0
        return false
      end

      @values = @target.getReady
      if @values[0] == 0
        return false
      end

      @values = @target.command(CHaserConnect::SEARCH, CHaserConnect::UP)
      item_counts[1] = count_item()
      if @values[0] == 0
        return false
      end

      if item_counts[0] > item_counts[1]
        direction = CHaserConnect::LEFT
      elsif item_counts[0] < item_counts[1]
        direction = CHaserConnect::UP
      else
        directions = [CHaserConnect::LEFT, CHaserConnect::UP]
        direction = directions[rand(directions.size)]
      end
    end

    return direction
  end

  # Clientプログラムが実際に実行されるメソッド  
  def simLoop
    x = 0
    y = 0
    #maps[y][x] = true
    no_blocks = Array.new
    
    # 最初だけ実行するコマンド
    direction = first_command()
    if !direction
      @target.close
      return
    end

    mode = direction
    old_mode = mode

    # --- ループ開始 ---
    loop do
      @values = @target.getReady
      if exit?
        break
      end

      @maps[y][x] += 1        # 通過した回数を記録
      no_blocks = check_block() # ブロックのチェック

      # 進みたい方向のブロック判定
      case mode
      when CHaserConnect::UP
        if @values[2] == 2
          mode = no_blocks[rand(no_blocks.size)]
        end
      when CHaserConnect::DOWN
        if @values[8] == 2
          mode = no_blocks[rand(no_blocks.size)]
        end
      when CHaserConnect::LEFT
        if @values[4] == 2
          mode = no_blocks[rand(no_blocks.size)]
        end
      when CHaserConnect::RIGHT
        if @values[6] == 2
          mode = no_blocks[rand(no_blocks.size)]
        end
      end

      if @maps[y][x] > 3 # 4回以上通ったらランダムで方向を決める
        mode = no_blocks[rand(no_blocks.size)]
      end

      # 四方にアイテムの判定
      if @values[2] == 3 || @values[4] == 3 || @values[6] == 3 || @values[8] == 3
        old_mode = mode
        mode = 10
      end

      # 周囲の敵の判定
      enemy = check_enemy
      if enemy
        if enemy == 2 || enemy == 4 || enemy == 6 || enemy == 8
          #old_mode = mode
          mode = 20
        elsif enemy == 1 || enemy == 3 || enemy == 7 || enemy == 9
          old_mode = mode
          mode = 30
        end 
      end

      case mode
      when CHaserConnect::UP
        @values = @target.command(CHaserConnect::WALK, CHaserConnect::UP)
        x =  x
        y -= 1 
      when CHaserConnect::DOWN
        @values = @target.command(CHaserConnect::WALK, CHaserConnect::DOWN)
        x =  x
        y += 1
      when CHaserConnect::LEFT
        @values = @target.command(CHaserConnect::WALK, CHaserConnect::LEFT)
        x -= 1
        y =  y
      when CHaserConnect::RIGHT
        @values = @target.command(CHaserConnect::WALK, CHaserConnect::RIGHT)
        x += 1
        y =  y
      when 10
        if @values[2] == 3
          @values = @target.command(CHaserConnect::WALK, CHaserConnect::UP)
          x =  x
          y -= 1
        elsif @values[4] == 3
          @values = @target.command(CHaserConnect::WALK, CHaserConnect::LEFT)
          x -= 1
          y =  y
        elsif @values[6] == 3
          @values = @target.command(CHaserConnect::WALK, CHaserConnect::RIGHT)
          x += 1
          y =  y
        else
          @values = @target.command(CHaserConnect::WALK, CHaserConnect::DOWN)
          x =  x
          y += 1
        end
        mode = old_mode
      when 20
        case enemy
        when 2
          @values = @target.command(CHaserConnect::PUT, CHaserConnect::UP)
        when 4
          @values = @target.command(CHaserConnect::PUT, CHaserConnect::LEFT)
        when 6
          @values = @target.command(CHaserConnect::PUT, CHaserConnect::RIGHT)
        else
          @values = @target.command(CHaserConnect::PUT, CHaserConnect::DOWN)
        end
      when 30
        case enemy
        when 1
          directions = [CHaserConnect::UP, CHaserConnect::LEFT]
          @values = @target.command(CHaserConnect::PUT, directions[rand(directions.size)])
        when 3
          directions = [CHaserConnect::UP, CHaserConnect::RIGHT]
          @values = @target.command(CHaserConnect::PUT, directions[rand(directions.size)])
        when 7
          directions = [CHaserConnect::DOWN, CHaserConnect::LEFT]
          @values = @target.command(CHaserConnect::PUT, directions[rand(directions.size)])
        when 9
          directions = [CHaserConnect::DOWN, CHaserConnect::LEFT]
          @values = @target.command(CHaserConnect::PUT, directions[rand(directions.size)])
        end
        mode = old_mode
      end

      if exit?
        break
      end
    end
    # --- ループ終了 ---
    @target.close
    return
  end
end

# mainメソッド
if __FILE__ == $0
  client = CHaserMemuro.new("芽室とうきび", ARGV[0].to_i, 'localhost')
  client.simLoop()
end