# -*-coding: utf-8 -*-

# CHaserConnect.rb
# CHaserクライアント通信プログラム
# Author:: Nobuyuki SAKAI 
# Date:: 2013/06
# Update:: 2013/09/08 Nobuyuki SAKAI Toメソッドを追加 
# これは書き換えない


require 'socket'

# CHaserConnect
# CHaserクライアント通信クラス  
class CHaserConnect
  # 定数
  UP = 0
  DOWN = 1
  LEFT = 2
  RIGHT = 3
  WALK = 0
  SEARCH = 1
  LOOK = 2
  PUT = 3

  # インスタンス生成
  # Param:: name(名前), port(ポート番号), host(IPアドレス，ホスト名)
  def initialize(name, port, host = 'localhost')
    begin
      if port == 2009 || port == 2010
        @name = name #.encode("Shift_JIS")
      else
        @name = name.encode("Shift_JIS")
      end
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
  # Return:: 制御情報と周囲情報
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
  # Return:: 制御情報と周囲情報
  def walkRight()
    puts "\"#{@name.encode("UTF-8")}\"はwalkRightをサーバに送信"
    @socket.puts("wr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左に進む
  # Return:: 制御情報と周囲情報
  def walkLeft()
    puts "\"#{@name.encode("UTF-8")}\"はwalkLeftをサーバに送信"
    @socket.puts("wl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上に進む
  # Return:: 制御情報と周囲情報
  def walkUp()
    puts "\"#{@name.encode("UTF-8")}\"はwalkUpをサーバに送信"
    @socket.puts("wu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下に進む
  # Return:: 制御情報と周囲情報
  def walkDown()
    puts "\"#{@name.encode("UTF-8")}\"はwalkDownをサーバに送信"
    @socket.puts("wd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右を見る
  # Return:: 制御情報と周囲情報
  def lookRight()
    puts "\"#{@name.encode("UTF-8")}\"はlookRightをサーバに送信"
    @socket.puts("lr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左を見る
  # Return:: 制御情報と周囲情報
  def lookLeft()
    puts "\"#{@name.encode("UTF-8")}\"はlookLeftをサーバに送信"
    @socket.puts("ll\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上を見る
  # Return:: 制御情報と周囲情報
  def lookUp()
    puts "\"#{@name.encode("UTF-8")}\"はlookUpをサーバに送信"
    @socket.puts("lu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下を見る
  # Return:: 制御情報と周囲情報
  def lookDown()
    puts "\"#{@name.encode("UTF-8")}\"はlookDownをサーバに送信"
    @socket.puts("ld\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右を見る(直線9マス)
  # Return:: 制御情報と周囲情報
  def searchRight()
    puts "\"#{@name.encode("UTF-8")}\"はsearchRightをサーバに送信"
    @socket.puts("sr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左を見る(直線9マス)
  # Return:: 制御情報と周囲情報
  def searchLeft()
    puts "\"#{@name.encode("UTF-8")}\"はsearchLeftをサーバに送信"
    @socket.puts("sl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上を見る(直線9マス)
  # Return:: 制御情報と周囲情報
  def searchUp()
    puts "\"#{@name.encode("UTF-8")}\"はsearchUpをサーバに送信"
    @socket.puts("su\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下を見る(直線9マス)
  # Return:: 制御情報と周囲情報
  def searchDown()
    puts "\"#{@name.encode("UTF-8")}\"はsearchDownをサーバに送信"
    @socket.puts("sd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右にブロックを置く
  # Return:: 制御情報と周囲情報
  def putRight()
    puts "\"#{@name.encode("UTF-8")}\"はputRightをサーバに送信"
    @socket.puts("pr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左にブロックを置く
  # Return:: 制御情報と周囲情報
  def putLeft()
    puts "\"#{@name.encode("UTF-8")}\"はputLeftをサーバに送信"
    @socket.puts("pl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上にブロックを置く
  # Return:: 制御情報と周囲情報
  def putUp()
    puts "\"#{@name.encode("UTF-8")}\"はputUpをサーバに送信"
    @socket.puts("pu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下にブロックを置く
  # Return:: 制御情報と周囲情報
  def putDown()
    puts "\"#{@name.encode("UTF-8")}\"はputDownをサーバに送信"
    @socket.puts("pd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 引数_direction_で指定した方向へ進む
  # Param:: direction(方向)
  # Return:: 制御情報と周囲情報を返す
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
  # Param:: direction(方向)
  # Return:: 制御情報と周囲情報を返す
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
  # Param:: direction(方向)
  # Return:: 制御情報と周囲情報を返す
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
  # Param:: direction(方向)
  # Return:: 制御情報と周囲情報を返す
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

  # 引数_kind_でコマンドを指定し引数_direction_で方向を指定する
  # Param:: kind(コマンドの種類), direction(方向) 
  # Return:: 制御情報と周囲情報を返す
  def command(kind, direction)
    case kind
    when "walk", 0
      case direction
      when "up", 0
        @socket.puts("wu\r\n")
      when "down", 1
        @socket.puts("wd\r\n")
      when "left", 2
        @socket.puts("wl\r\n")
      when "right", 3
        @socket.puts("wr\r\n")
      end
    when "search", 1
      case direction
      when "up", 0
        @socket.puts("su\r\n")
      when "down", 1
        @socket.puts("sd\r\n")
      when "left", 2
        @socket.puts("sl\r\n")
      when "right", 3
        @socket.puts("sr\r\n")
      end   
    when "look", 2
      case direction
      when "up", 0
        @socket.puts("lu\r\n")
      when "down", 1
        @socket.puts("ld\r\n")
      when "left", 2
        @socket.puts("ll\r\n")
      when "right", 3
        @socket.puts("lr\r\n")
      end   
    when "put", 3
      case direction
      when "up", 0
        @socket.puts("pu\r\n")
      when "down", 1
        @socket.puts("pd\r\n")
      when "left", 2
        @socket.puts("pl\r\n")
      when "right", 3
        @socket.puts("pr\r\n")
      end   
    end

    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end



  # 文字列を整数配列に変換
  # Param:: str(サーバから返ってきた制御情報と周囲情報の文字列)
  # Return:: 文字列を整数列に変換した配列
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
  target = CHaserConnect.new("test", 2010, 'localhost')
  
  # 2byte文字版 エンコードの問題のチェック（文字化け等々）  
  #target = CHaserConnect.new("テスト", 40000, 'localhost')
  #----

  values = Array.new(10)

  loop do
    values = target.getReady
    if values[0] == 0
      break
    end

    values = target.command(CHaserConnect::SEARCH, CHaserConnect::UP)
    if values[0] == 0
      break
    end
  end

  target.close
end
