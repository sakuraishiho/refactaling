# app/decorators/player_decorator.rb
class PlayerDecorator < ApplicationDecorator
  delegate_all
  
  # フルネームを組み立てるメソッド
  def full_name
    "#{object.firstname} #{object.lastname}" # 'object'を使用してPlayerの属性にアクセス
  end

  def home_base
    "Home base for #{object.name}" # 'object'を使用
  end
end