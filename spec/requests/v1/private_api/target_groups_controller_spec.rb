require 'rails_helper'

describe 'Private API' do
  describe 'List target groups' do
    let!(:country) { create(:country) }
    let(:url) { "/v1/private_api/target_groups/#{country.country_code}" }
    let!(:api_key) { create(:api_key) }
    let(:headers) { { 'Authorization' => "Token token=\"#{api_key.token}\""} }

    describe '#index' do
      it 'should respond' do
        get url, nil, headers
        expect(response).to be_success
      end

      it 'should be secured' do
        get url
        expect(response).to be_unauthorized
      end

      context 'nested target group' do
        let!(:root) { create(:target_group, countries: [country]) }
        let!(:child) { create(:target_group, parent: root) }

        it 'should contain root group' do
          get url, nil, headers
          json = JSON.parse(response.body, {symbolize_names: true})
          expect(json.first[:id]).to eq root.id
        end

        it 'should contain a child' do
          get url, nil, headers
          json = JSON.parse(response.body, {symbolize_names: true})
          expect(json.first[:children].first[:id]).to eq child.id
        end
      end

      context 'multiple root nodes' do
        let!(:matching_roots) { create_list(:target_group, 2, countries: [country]) }
        let!(:not_matching_root) { create(:target_group, countries: [create(:country)]) }

        it 'should return only nodes for a proper country' do
          get url, nil, headers
          json = JSON.parse(response.body, {symbolize_names: true})
          ids = json.map { |root| root[:id] }
          expect(ids).to match_array(matching_roots.map(&:id))
        end
      end

      context 'single node' do
        let!(:root) { create(:target_group, countries: [country]) }
        it 'should have a proper structure' do
          get url, nil, headers
          json = JSON.parse(response.body, {symbolize_names: true})
          expect(json.first).to eq({
            id: root[:id],
            name: root[:name],
            external_id: root[:external_id],
            panel_provider_id: root[:panel_provider_id],
            secret_code: root[:secret_code]
          })
        end
      end
    end
  end
end
