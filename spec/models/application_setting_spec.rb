require 'rails_helper'

describe ApplicationSetting do
  describe '#application_name=' do
    example '1文字以上16文字以下でなければならない' do
      as = ApplicationSetting.first

      as.application_name = 'A'
      expect(as).to be_valid

      as.application_name = ''
      expect(as).to be_invalid

      as.application_name = 'A' * 17
      expect(as).to be_invalid
    end
  end

  describe '#session_timeout=' do
    example '0以上の整数値でなければならない' do
      as = ApplicationSetting.first

      as.session_timeout = 0
      expect(as).to be_valid

      as.session_timeout = 1
      expect(as).to be_valid

      as.session_timeout = -1
      expect(as).to be_invalid

      as.session_timeout = 0.5
      expect(as).to be_invalid
    end
  end
end
