class ClubDecorator < ApplicationDecorator
  delegate_all
  def total_result_on(year=nil)
    year = Date.current.year unless year

    matches = matches_on(year).count
    won = win_on(year)
    lost = lost_on(year)
    draw = draw_on(year)

    "matches: #{matches} won: #{won} lost: #{lost} draw: #{draw}"
  end

  def full_names
    players.decorate.map(&:full_name).join(", ")
  end

    # home_baseメソッドの定義
  def home_base
    "#{object.hometown} - #{object.country}"
  end
end
