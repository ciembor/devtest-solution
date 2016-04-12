require 'rails_helper'

describe 'Private API' do
  describe 'List locations' do
    let!(:panel_provider) { create(:panel_provider, code: 'FirstPanel') }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let(:url) { "/v1/private_api/evaluate_target" }
    let!(:api_key) { create(:api_key) }
    let(:headers) { { 'Authorization' => "Token token=\"#{api_key.token}\""} }

    describe '#create' do
      let(:params) { { country_code: country.country_code, target_group_id: 1, locations: { id: 123, panel_size: 200 } } }

      it 'should respond' do
        VCR.use_cassette 'time' do
          post url, params, headers
          expect(response).to be_success
        end
      end

      it 'should be secured' do
        VCR.use_cassette 'time' do  
          post url
          expect(response).to be_unauthorized
        end
      end

      it 'should return evaluated price' do
        VCR.use_cassette 'time' do
          post url, params, headers
          json = JSON.parse(response.body, {symbolize_names: true})
          expect(json[:price]).to eq '6.28 PLN'
        end
      end
    end
  end
end
