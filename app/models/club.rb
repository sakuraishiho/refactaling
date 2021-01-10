class Club < ApplicationRecord
  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :players

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def total_result
    # その年の通算成績を返す

    # 年度の指定があればそれを使う。なければ今年
    # matches.where(kicked_off_at: year).each do |match|

      # case文を使う
      # case match.result
      # when winner
      #   win++
      # when loser
      #   lose++
      # when draw
      #   draw++
      # end

      # if 文を使う
      # if won?(match)
      #   won++
      # elsif lost?(match)
      #   lost++
      # elsif draw?(match)
      #   draw++
      # end
    # end
      # [win, lose, draw]
  end

  def won?(match)
    match.winner == self
  end

  def lost?(match)
    match.loser == self
  end

  def draw?(match)
    match.draw?
  end

  def win_on(year)
    year = Date.new(2021, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if won?(match)
    end
    count
  end

  def lost_on(year)
    year = Date.new(2021, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if lost?(match)
    end
    count
  end

  def draw_on(year)
    year = Date.new(2021, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if draw?(match)
    end
    count
  end
end
