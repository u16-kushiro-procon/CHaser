# -*- coding: utf-8 -*-

# Test用プログラム

#require '.\CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows
require './CHaserConnect.rb' # UNIX

# サーバに接続
#target = CHaserConnect.new("名前", ポート番号, 'ipアドレス') # 名前は4文字まで
# 例
target = CHaserConnect.new("釧路", 2009, '192.168.5.11') # そのときに合わせて書き換える
#target = CHaserConnect.new("", ARGV[0], 'localhost')  プログラムを起動する際にポート番号を指定する場合

# 配列の初期化
values = Array.new(10) # 書き換えない

loop do # 無限ループ
  #----- ここから -----

  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.walkUp
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0 # 先頭が0になったら終了
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
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.lookUp
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.lookRight
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.lookDown
  if values[0] == 0
    break
  end
  values = target.getReady
  if values[0] == 0
    break
  end
  values = target.lookLeft
  if values[0] == 0
    break
  end

  #----- ここまで -----
end

target.close # ソケットを閉じる
