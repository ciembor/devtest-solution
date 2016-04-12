require 'rails_helper'

describe FirstPanel do
  describe '#price' do
    it 'should return proper price' do
      VCR.use_cassette 'time' do
        expect(subject.price).to eq '6.28 PLN'
      end
    end
  end
end
