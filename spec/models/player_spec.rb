require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#age' do
    let(:player) { FactoryBot.create(:player, birthday: Date.current.years_ago(20)) }

    it '誕生日から算出した年齢を返す' do
      expect(player.age).to eq 20
    end
  end
end
