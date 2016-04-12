require 'rails_helper'

describe 'Public API' do
  describe 'List locations' do
    let!(:country) { create(:country) }
    let(:url) { "/v1/public_api/locations/#{country.country_code}" }

    describe '#index' do
      it 'should respond' do
        get url
        expect(response).to be_success
      end

      context 'multiple location groups' do
        let!(:not_mathing_location_group) { create(:location_group, locations: [create(:location)]) }
        let!(:locations) { create_list(:location, 3) }
        let!(:first_matching_group) { create(:location_group, country: country, locations: [locations.first]) }
        let!(:second_matching_group) { create(:location_group, country: country, locations: locations.last(2)) }

        it 'should return locations for specific country' do
          get url
          json = JSON.parse(response.body)
          ids = json.map { |location| location['id'] }
          expect(ids).to match_array(locations.map(&:id))
        end
      end

      context 'single location' do
        let!(:location) { create(:location) }
        let!(:location_group) { create(:location_group, country: country, locations: [location]) }

        it 'should have a proper structure' do
          get url
          json = JSON.parse(response.body, {symbolize_names: true})
          expect(json.first).to eq({
            id: location[:id],
            name: location[:name],
            external_id: location[:external_id]
          })
        end
      end
    end
  end
end
