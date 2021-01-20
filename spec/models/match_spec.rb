require 'rails_helper'

RSpec.describe Match, type: :model do
  describe '#winner' do

  context '引き分けでないとき' do
      let(:winner_club) { FactoryBot.create(:club, name: "Winner") }
      let(:match) { FactoryBot.create(:match, home_team: winner_club, home_team_score: 2, away_team_score: 0) }

      it '勝利した club が返る' do
        expect(match.winner).to eq winner_club
      end
    end

    context '引き分けのとき' do
      let(:draw_match) { FactoryBot.create(:match, home_team_score: 0, away_team_score: 0) }

      it 'nil が返る' do
        expect(draw_match.winner).to be nil
      end
    end
  end
end
