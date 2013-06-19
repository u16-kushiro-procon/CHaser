# -*-coding: utf-8 -*-

# CHaser client

require 'socket'

class CHaserConnect
  def initialize(name, host = 'localhost', port)
    @name = name
    @host = host
    @port = port
    @socket = TCPSocket.open(host, port)
    #@socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    #sockaddr = Socket.sockaddr_in(@port, @host)
    #@socket.connect(sockaddr)
    @socket.puts(@name)
  end

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

  def lookRight()
    @socket.puts("lr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def lookLeft()
    @socket.puts("ll\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def lookUp()
    @socket.puts("lu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def lookDown()
    @socket.puts("ld\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def searchRight()
    @socket.puts("sr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def searchLeft()
    @socket.puts("sl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def searchUp()
    @socket.puts("su\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def searchDown()
    @socket.puts("sd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def putRight()
    @socket.puts("pr\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def putLeft()
    @socket.puts("pl\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def putUp()
    @socket.puts("pu\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def putDown()
    @socket.puts("pd\r\n")
    msg = @socket.gets
    results = parseInt(msg)
    @socket.puts("\#\r\n")
    return results
  end

  def parseInt(str)
    results = [9,9,9,9,9,9,9,9,9,9]

    for i in 0..9
      results[i] = str[i].to_i
    end

    return results
  end

  def close
    @socket.close
  end
end
