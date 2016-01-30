require 'rails_helper'

describe Email do
  let(:email) { build(:email, address: 'test@example.com') }
  describe '#exchanging=' do
    example '真値を与えるとvalidation後にaddress_for_indexの"@"が"%"に置き換わる' do
      email.exchanging = true
      email.validate
      expect(email.address_for_index).to eq('test%example.com')
    end
  end
end
