require 'rails_helper'

RSpec.describe Club, type: :model do
  describe '#matches' do
    let(:mancity) { FactoryBot.create(:club, name: "Man City") }
    let(:manutd) { FactoryBot.create(:club, name: "Man United") }
    let(:chelsea) { FactoryBot.create(:club, name: "Chelsea") }

    let(:home_match) { FactoryBot.create(:match, home_team: mancity, away_team: manutd)}
    let(:away_match) { FactoryBot.create(:match, home_team: manutd, away_team: mancity)}
    let!(:not_participated_match) { FactoryBot.create(:match, home_team: manutd, away_team: chelsea)}

    it '自クラブが home_team または away_team である match だけが返る' do
      expect(mancity.matches).to match_array([home_match, away_match])
    end
  end

  describe '#matches_on' do
    let(:mancity) { FactoryBot.create(:club, name: "Man City") }

    let(:match_on_current_year) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1), home_team: mancity)}
    let!(:match_on_past_year) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.years_ago(1).year, 1, 1), home_team: mancity)}
    let!(:match_on_future_year) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.years_since(1).year, 1, 1), home_team: mancity)}
    let!(:match_on_current_year_not_participated_in) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1)) }

    context '年を指定した場合' do
      let(:year) { Date.current.year }

      it '自クラブが home_team または away_team であり、kicked_of_at が spec 実行時の年である match だけが返る' do
        expect(mancity.matches_on(year)).to match_array([match_on_current_year])
      end
    end

    context '年を指定しない場合' do
      let(:year) { nil }

      it 'nil が返る' do
        expect(mancity.matches_on(year)).to eq nil
      end
    end
  end

  describe '#total_result_on' do
    let(:mancity) { FactoryBot.create(:club, name: "Man City") }

    before do
      # create matches on last year
      # 6戦1勝2敗3分
      first_match_on_last_year =
        FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1).years_ago(1), home_team: mancity, home_team_score: 1, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(1), home_team: mancity, home_team_score: 0, away_team_score: 1)
      FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(2), home_team: mancity, home_team_score: 0, away_team_score: 1)
      FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(3), home_team: mancity, home_team_score: 0, away_team_score: 1)
      FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(4), home_team: mancity, home_team_score: 0, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(5), home_team: mancity, home_team_score: 0, away_team_score: 0)

      # create matches on current_year
      # 6戦3勝2敗1分
      first_match_on_current_year =
        FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1), home_team: mancity, home_team_score: 1, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: first_match_on_current_year.kicked_off_at.weeks_since(1), home_team: mancity, home_team_score: 1, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: first_match_on_current_year.kicked_off_at.weeks_since(2), home_team: mancity, home_team_score: 1, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: first_match_on_current_year.kicked_off_at.weeks_since(3), home_team: mancity, home_team_score: 0, away_team_score: 1)
      FactoryBot.create(:match, kicked_off_at: first_match_on_current_year.kicked_off_at.weeks_since(4), home_team: mancity, home_team_score: 0, away_team_score: 1)
      FactoryBot.create(:match, kicked_off_at: first_match_on_current_year.kicked_off_at.weeks_since(5), home_team: mancity, home_team_score: 0, away_team_score: 0)
    end

    context '去年を指定した場合' do
      let(:year) { Date.new(Date.current.year, 1, 1).years_ago(1).year }

      it '去年の結果が返る' do
        expect(mancity.total_result_on(year)).to match_array([6, 1, 2, 3])
      end
    end

    context '年を指定しない場合' do
      let(:year) { nil }

      it '実行時の年の結果が返る' do
        expect(mancity.total_result_on(year)).to match_array([6, 3, 2, 1])
      end
    end
  end

  describe '#win_on' do
    let(:mancity) { FactoryBot.create(:club, name: "Man City") }

    before do
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 2, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 0, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 0, away_team_score: 2)
    end

    it '勝利した試合数=1が返る' do
      expect(mancity.win_on(2021)).to eq 1
    end
  end

  describe '#won?' do
    let(:mancity) { FactoryBot.create(:club, name: "Man City") }
    let(:won_match) { FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 2, away_team_score: 0)}

    before do
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 2, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 0, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: mancity, home_team_score: 0, away_team_score: 2)
    end

    it 'true' do
      expect(mancity.won?(won_match)).to be_truthy
    end
  end

  describe '#players_average_age' do
    let(:mancity) { FactoryBot.create(:club, name: "Man City") }

    before do
      # create 20, 25, and 30 years old players. Average should be 25
      FactoryBot.create(:player, club: mancity, birthday: Date.current.years_ago(20))
      FactoryBot.create(:player, club: mancity, birthday: Date.current.years_ago(25))
      FactoryBot.create(:player, club: mancity, birthday: Date.current.years_ago(30))
    end

    it '平均年齢である25を返す' do
      expect(mancity.players_average_age).to eq 25.0
    end
  end
end
