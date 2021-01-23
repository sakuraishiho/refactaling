require 'rails_helper'

describe '試合結果CRUD機能', type: :system do
  describe '試合結果一覧表示画面' do
    describe '画面遷移機能' do
      before do
        home = FactoryBot.create(:club, name: "Home FC")
        away = FactoryBot.create(:club, name: "Away FC")
        FactoryBot.create(:match, home_team: home, home_team_score: 2, away_team_score: 0, away_team: away, kicked_off_at: DateTime.new(2021, 1, 1, 19, 00))
      end

      context '一覧画面にアクセスした時' do
        before do
          visit root_path
        end

        it '一覧画面が表示される' do
          expect(page).to have_content 'Matches'
          expect(page).to have_content 'Home FC'
          expect(page).to have_content 'Away FC'
          expect(page).to have_content '2021-01-01 19:00:00'
        end
      end
    end
  end

  describe '試合結果登録画面' do
    describe '試合結果登録機能' do
      before do
        FactoryBot.create(:league, name: "Hoge League")
        FactoryBot.create(:club, name: "Home FC")
        FactoryBot.create(:club, name: "Away FC")

        visit new_match_path
      end

      context 'キックオフ時間、対戦チーム、スコアを入力した時' do
        before do
          select '2021', from: 'match[kicked_off_at(1i)]'
          select 'January', from: 'match[kicked_off_at(2i)]'
          select '1', from: 'match[kicked_off_at(3i)]'
          select '19', from: 'match[kicked_off_at(4i)]'
          select '30', from: 'match[kicked_off_at(5i)]'
          select 'Hoge League', from: 'match[league_id]'
          select 'Home FC', from: 'match[home_team_id]'
          select 'Away FC', from: 'match[away_team_id]'
          fill_in 'match_home_team_score', with: 2
          fill_in 'match_away_team_score', with: 0

          click_on 'Create Match'
        end

        it '登録できる' do
          expect(page).to have_content '2021-01-01 19:30:00'
          expect(page).to have_content 'Home FC'
          expect(page).to have_content 'Away FC'
          expect(page).to have_content "Home team score: 2"
          expect(page).to have_content "Away team score: 0"
        end
      end
    end
  end
end
