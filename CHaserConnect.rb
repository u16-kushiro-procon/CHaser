# -*-coding: utf-8 -*-

# CHaserクライアント通信プログラム
# これは書き換えない

require 'socket'

class CHaserConnect
  def initialize(name, port, host='localhost')
    @name = name.encode('Shift_JIS')
    @host = host
    @port = port
    @socket = TCPSocket.open(host, port) # TCPソケットを開く
    @socket.puts(@name) # 名前を送信
  end

  # 準備信号
  def getReady()
    msg = @socket.gets
    @socket.puts("gr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    return results
  end

  # 右に進む
  def walkRight()
    @socket.puts("wr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左に進む
  def walkLeft()
    @socket.puts("wl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上に進む
  def walkUp()
    @socket.puts("wu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下に進む
  def walkDown()
    @socket.puts("wd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右を見る
  def lookRight()
    @socket.puts("lr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左を見る
  def lookLeft()
    @socket.puts("ll\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上を見る
  def lookUp()
    @socket.puts("lu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下を見る
  def lookDown()
    @socket.puts("ld\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右を見る(直線9マス)
  def searchRight()
    @socket.puts("sr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左を見る(直線9マス)
  def searchLeft()
    @socket.puts("sl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上を見る(直線9マス)
  def searchUp()
    @socket.puts("su\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下を見る(直線9マス)
  def searchDown()
    @socket.puts("sd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 右にブロックを置く
  def putRight()
    @socket.puts("pr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 左にブロックを置く
  def putLeft()
    @socket.puts("pl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 上にブロックを置く
  def putUp()
    @socket.puts("pu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 下にブロックを置く
  def putDown()
    @socket.puts("pd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  # 文字列を整数配列に変換
  def parseInt(str)
    results = [9,9,9,9,9,9,9,9,9,9]

    for i in 0..9
      results[i] = str[i].to_i
    end

    return results
  end

  # ソケットを閉じる
  def close
    @socket.close
  end
end
