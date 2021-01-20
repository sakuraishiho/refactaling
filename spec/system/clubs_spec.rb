require 'rails_helper'

describe 'クラブCRUD機能', type: :system do
  describe 'クラブ詳細画面' do
    describe '画面遷移機能' do
      let!(:club) { FactoryBot.create(:club, name: "Blue FC") }

      before do
        first_match_on_last_year =
          FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1), home_team: club, home_team_score: 1, away_team_score: 0)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(1), home_team: club, home_team_score: 0, away_team_score: 1)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(2), home_team: club, home_team_score: 0, away_team_score: 1)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(3), home_team: club, home_team_score: 0, away_team_score: 1)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(4), home_team: club, home_team_score: 0, away_team_score: 0)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(5), home_team: club, home_team_score: 0, away_team_score: 0)

        # create 20, 25, and 30 years old players. Average should be 25
        FactoryBot.create(:player, club: club, birthday: Date.current.years_ago(20), firstname: "Taro", lastname: "Tanaka")
        FactoryBot.create(:player, club: club, birthday: Date.current.years_ago(25))
        FactoryBot.create(:player, club: club, birthday: Date.current.years_ago(30))
      end

      context 'クラブ詳細画面にアクセスした時' do
        before do
          visit club_path(club)
        end

        it '戦績が正しく表示される' do
          expect(page).to have_content "6戦1勝2分3敗"
        end

        it '選手のフルネームが正しく表示される' do
          expect(page).to have_content 'Taro Tanaka'
        end

        it '選手の平均年齢が正しく表示される' do
          expect(page).to have_content '25.5'
        end
      end
    end
  end
end
