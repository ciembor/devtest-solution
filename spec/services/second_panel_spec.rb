require 'rails_helper'

describe SecondPanel do
  describe '#price' do
    it 'should return proper price' do
      VCR.use_cassette 'news' do
        expect(subject.price).to eq '36.00 GBP'
      end
    end
  end
end
