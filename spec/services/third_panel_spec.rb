require 'rails_helper'

describe ThirdPanel do
  describe '#price' do
    it 'should return proper price' do
      VCR.use_cassette 'time' do
        expect(subject.price).to eq '10.34 Euro'
      end
    end
  end
end
