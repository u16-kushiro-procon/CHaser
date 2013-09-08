# -*-coding: utf-8 -*-

=begin CHaserConnect.rb
CHaserクライアント通信プログラム
Author:: Nobuyuki SAKAI 
これは書き換えない
=end

require 'socket'

class CHaserConnect

  # 定数
  UP = 0
  DOWN = 1
  LEFT = 2
  RIGHT = 3

  # インスタンス生成
  def initialize(name, port, host='localhost')
    begin
      @name = name #.encode("Shift_JIS")
      @host = host
      @port = port
      @socket = TCPSocket.open(host, port) # TCPソケットを開く
      @socket.puts(@name) # 名前を送信
    rescue
      puts "\"#{@name.encode("UTF-8")}\"はサーバに接続出来ませんでした"
      puts "サーバが起動しているかどうか or ポート番号、IPアドレスを確認してください"
    else
      puts "\"#{@name.encode("UTF-8")}\"はサーバに接続しました"
    end
  end

  # 準備信号
  def getReady()
    begin
      puts "\"#{@name.encode("UTF-8")}\"はgetReadyをサーバに送信"
      msg = @socket.gets
      @socket.puts("gr\r\n")
      msg = @socket.gets
      results = parseInt(msg)
      return results
    rescue
      puts "\"#{@name.encode("UTF-8")}\"はgetReadyをサーバに送信できませんでした"
    end
  end

  # 右に進む
  def walkRight()
    puts "\"#{@name.encode("UTF-8")}\"はwalkRightをサーバに送信"
    @socket.puts("wr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左に進む
  def walkLeft()
    puts "\"#{@name.encode("UTF-8")}\"はwalkLeftをサーバに送信"
    @socket.puts("wl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上に進む
  def walkUp()
    puts "\"#{@name.encode("UTF-8")}\"はwalkUpをサーバに送信"
    @socket.puts("wu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下に進む
  def walkDown()
    puts "\"#{@name.encode("UTF-8")}\"はwalkDownをサーバに送信"
    @socket.puts("wd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右を見る
  def lookRight()
    puts "\"#{@name.encode("UTF-8")}\"はlookRightをサーバに送信"
    @socket.puts("lr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左を見る
  def lookLeft()
    puts "\"#{@name.encode("UTF-8")}\"はlookLeftをサーバに送信"
    @socket.puts("ll\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上を見る
  def lookUp()
    puts "\"#{@name.encode("UTF-8")}\"はlookUpをサーバに送信"
    @socket.puts("lu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下を見る
  def lookDown()
    puts "\"#{@name.encode("UTF-8")}\"はlookDownをサーバに送信"
    @socket.puts("ld\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右を見る(直線9マス)
  def searchRight()
    puts "\"#{@name.encode("UTF-8")}\"はsearchRightをサーバに送信"
    @socket.puts("sr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左を見る(直線9マス)
  def searchLeft()
    puts "\"#{@name.encode("UTF-8")}\"はsearchLeftをサーバに送信"
    @socket.puts("sl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上を見る(直線9マス)
  def searchUp()
    puts "\"#{@name.encode("UTF-8")}\"はsearchUpをサーバに送信"
    @socket.puts("su\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下を見る(直線9マス)
  def searchDown()
    puts "\"#{@name.encode("UTF-8")}\"はsearchDownをサーバに送信"
    @socket.puts("sd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右にブロックを置く
  def putRight()
    puts "\"#{@name.encode("UTF-8")}\"はputRightをサーバに送信"
    @socket.puts("pr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左にブロックを置く
  def putLeft()
    puts "\"#{@name.encode("UTF-8")}\"はputLeftをサーバに送信"
    @socket.puts("pl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上にブロックを置く
  def putUp()
    puts "\"#{@name.encode("UTF-8")}\"はputUpをサーバに送信"
    @socket.puts("pu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下にブロックを置く
  def putDown()
    puts "\"#{@name.encode("UTF-8")}\"はputDownをサーバに送信"
    @socket.puts("pd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 引数_direction_で指定した方向へ進む
  # ==== Return
  # 制御情報と周囲情報を返す  
  def walkTo(direction)
    tmp = Array.new(10)

    case direction
    when "up", 0
      tmp = walkUp
    when "down", 1
      tmp = walkDown
    when "left", 2
      tmp = walkLeft
    when "right", 3
      tmp = walkRight
    else
      puts "指定された引数は使えません"
    end

    return tmp
  end

  # 引数_direction_で指定した方向へlookする
  # ==== Return
  # 制御情報と周囲情報を返す
  def lookTo(direction)
    tmp = Array.new(10)

    case direction
    when "up", 0
      tmp = lookUp
    when "down", 1
      tmp = lookDown
    when "left", 2
      tmp = lookLeft
    when "right", 3
      tmp = lookRight
    else
      puts "指定された引数は使えません"
    end

    return tmp
  end

  # 引数_direction_で指定した方向へsearchする
  # ==== Return
  # 制御情報と周囲情報を返す  
  def searchTo(direction)
    tmp = Array.new(10)

    case direction
    when "up", 0
      tmp = searchUp
    when "down", 1
      tmp = searchDown
    when "left", 2
      tmp = searchLeft
    when "right", 3
      tmp = searchRight
    else
      puts "指定された引数は使えません"
    end

    return tmp
  end

  # 引数_direction_で指定した方向へputする
  # ==== Return
  # 制御情報と周囲情報を返す  
  def putTo(direction)
    tmp = Array.new(10)

    case direction
    when "up", 0
      tmp = putUp
    when "down", 1
      tmp = putDown
    when "left", 2
      tmp = putLeft
    when "right", 3
      tmp = putRight
    else
      puts "指定された引数は使えません"
    end

    return tmp
  end



  # 文字列を整数配列に変換
  def parseInt(str)
    results = [9,9,9,9,9,9,9,9,9,9]

    for i in 0..9
      results[i] = str[i].to_i
      print results[i]
    end

    print "\n"
    return results
  end

  # ソケットを閉じる
  def close
    @socket.close
  end
end

# テスト用
# "CHaserConnect.rb"自体を実行すると先攻としてサーバに接続 
if __FILE__ == $0
  
  #----必要に合わせてコメントアウトで切り替える  
  # 1byte文字版
  target = CHaserConnect.new("test", 2009, 'localhost')
  
  # 2byte文字版 エンコードの問題のチェック（文字化け等々）  
  #target = CHaserConnect.new("テスト", 40000, 'localhost')
  #----

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
  end

  target.close
end
