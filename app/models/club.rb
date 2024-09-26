class Club < ApplicationRecord
  has_one_attached :logo

  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :players
  belongs_to :league

  # クラブ所属選手の平均年齢を計算するメソッド
  def average_age_of_players
    return 0 if players.empty?
  
    average_age = players.map(&:age).sum / players.size.to_f
    average_age.round(1)  # 小数点第1位まで丸める
  end

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def matches_on(year = nil)
    return nil unless year

    matches.where(kicked_off_at: Date.new(year, 1, 1).in_time_zone.all_year)
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

  # 新しく追加するプライベートメソッド
  private

  def count_matches_on(year, result_check)
    year = Date.new(year, 1, 1)
    matches.where(kicked_off_at: year.all_year).count do |match|
      result_check.call(match)
    end
  end

  public

  def win_on(year)
    count_matches_on(year, ->(match) { won?(match) })
  end

  def lost_on(year)
    count_matches_on(year, ->(match) { lost?(match) })
  end

  def draw_on(year)
    count_matches_on(year, ->(match) { draw?(match) })
  end

end
