class Match < ApplicationRecord
  belongs_to :league
  belongs_to :home_team, class_name: "Club", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Club", foreign_key: "away_team_id"

  scope :draw, -> { where("home_team_score = away_team_score") }

  def winner
    return nil if draw?

    if home_team_score > away_team_score
      home_team
    elsif away_team_score > home_team_score
      away_team
    end
  end

  def loser
    return nil if draw?

    if away_team_score > home_team_score
      home_team
    elsif home_team_score > away_team_score
      away_team
    end
  end

  def draw?
    home_team_score == away_team_score
  end
end
