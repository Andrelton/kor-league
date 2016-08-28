require 'rails_helper'

RSpec.describe FootballDataClient, type: :model do
  let(:test_client) do
    FootballDataClient.new
  end

  let(:all_fixtures) do
    test_client.get_all_fixtures
  end

  describe '#get_all_fixtures' do
    it 'returns an array of hashes' do
      expect(all_fixtures).to be_an Array
      expect(all_fixtures.first).to be_a Hash
    end
  end

end
