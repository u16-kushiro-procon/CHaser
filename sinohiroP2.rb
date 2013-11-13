# -*- coding: utf-8 -*-
# Test用プログラム ひたすら四方をsearch（調べる）

require '.\CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
#target = CHaserConnect.new("名前", ポート番号, 'ipアドレス') # 名前は4文字まで
# 例
target = CHaserConnect.new("篠田", 40000, 'localhost') # そaluvのときに合わせて書き換える

values = Array.new(10) # 書き換えない
mode = 1
old_mode=mode
move=1

loop do # 無限ループ
  #----- ここから -----
  #mode=1 したに移動
  #mode=2 右に移動
  #mode=3 上に移動
  #mode=4 左に移動
  #mode=6 ダミー（動かない）

  if move==1
    values = target.getReady
    if values[0] == 0 # 先頭が0になったら終了
      break
    end
  end
  
  move  = 0
  
  if  values[6] ==3
    mode=2
  elsif  values[2] ==3
    mode=3
  elsif  values[8] ==3
    mode=1
  elsif  values[4] ==3
    mode=4
  elsif  values[1]==3
    mode=3
  elsif  values[3] ==3
    mode=3
  elsif  values[7] ==3
    mode=1
  elsif  values[9] ==3
    mode=1
  end 


  if mode!=6
    old_mode=mode
  end

  if  values[1] ==1
    if values[6]==2 ||values[8]==2
      mode=6
    else 
      if rand(2)==0
        mode=2
      else
        mode=1
      end
    end  
  end
  
  if values[3] ==1
    if values[4]==2 ||values[8]==2
      mode=6
    else 
      if rand(2)==0
        mode=4
      else
        mode=1
      end 
    end      
  end
  
  if values[7] ==1
    if values[2]==2 ||values[6]==2
      mode=6
    else
      if rand(2)==0
        mode=3
      else
        mode=2
      end   
    end 
  end
  
  if values[9] ==1
    if values[4]==2 ||values[2]==2
      mode=6
    else 
      if rand(2)==0
        mode=4
      else
        mode=3
      end    
    end
  end
  
  if  values[2] ==1
    values =target.putUp
  elsif  values[8] ==1
    values =target.putDown
  elsif  values[4] ==1
    values =target.putLeft
  elsif  values[6] ==1
    values =target.putRight
  end    
  #  if move != 1
   # if values[2] !=2 || values[2] ==3
    #  values =target.walkUp
    #elsif values[8] !=2 ||  values[8] ==3
     # values = target.walkDown
    #elsif values[4] !=2 || values[4] ==3
     # values =target.walkLeft
    #elsif values[6] !=2 || values[6] ==3
     # values =target.walkRight
      
    #end
  #end

  loop do # 無限ループ
  
    if mode==1 
      if values[8]!=2
        values = target.walkDown
        move =1
      else
        if rand(2)==0
         mode=2
        else 
         mode=4
        end   
      end
    elsif mode==2
      if values[6]!=2
        values =target.walkRight
        move =1
      else  
        if rand(2)==0
          mode=3
        else
          mode=1
        end  
      end
    elsif mode==3
      if values[2]!=2
        values =target.walkUp
        move =1
      else
        if rand(2)==0
          mode=2
        else
          mode=4
        end    
      end  
    elsif mode==4
      if values[4]!=2
        values =target.walkLeft
        move =1
      else
        if rand(2)==0
          mode=3
        else
          mode=1
        end    
      end
    elsif mode==6
        values=target.lookRight
        move=1
        mode=old_mode
    end
      if move==1
        break
      end
   end
  #----- ここまで -----
end
 
target.close # ソケットを閉じる
