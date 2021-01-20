class Club < ApplicationRecord
  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :players

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def matches_on(year = nil)
    return nil unless year

    matches.where(kicked_off_at: Date.new(year, 1, 1).in_time_zone.all_year)
  end

  def total_result_on(year=nil)
    year = Date.current.year unless year

    [matches_on(year).count, win_on(year), lost_on(year), draw_on(year)]
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
    year = Date.new(year, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if won?(match)
    end
    count
  end

  def lost_on(year)
    year = Date.new(year, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if lost?(match)
    end
    count
  end

  def draw_on(year)
    year = Date.new(year, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if draw?(match)
    end
    count
  end

  def players_average_age
    (players.sum(&:age) / players.length).to_f
  end
end
