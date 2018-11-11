require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe '.operations' do
    let!(:setting) { create(:setting) }
    let!(:categories) { create_list(:category, 5) }

    before do
      categories.each do |cat|
        create_list(:operation, 5, category: cat)
      end

      categories.sample(3).each { |cat| cat.update(setting: setting)}
    end

    it 'returns proper results' do
      result = setting.operations.count
      expect(result).to eq(15)
    end
  end
end
