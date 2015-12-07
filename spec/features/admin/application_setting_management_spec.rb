require 'rails_helper'

feature '管理者によるアプリケーション設定' do
  include FeaturesSpecHelper
  let(:administrator) { create(:administrator) }

  before do
    switch_namespace(:admin)
    login_as_administrator(administrator)
    click_link 'アプリケーション設定'
  end

  scenario '管理者が各種アプリケーション設定を正しく更新する' do
    fill_in 'アプリケーション名', with: 'Philemon'
    fill_in 'セッションタイムアウト（分）', with: '0'
    click_button '更新'

    expect(page).to have_css('header span.notice')

    setting = ApplicationSetting.first
    expect(setting.application_name).to eq('Philemon')
    expect(setting.session_timeout).to eq(0)
  end

  scenario '管理者が各種アプリケーション設定に不正な値を入力する' do
    fill_in 'アプリケーション名', with: ''
    fill_in 'セッションタイムアウト（分）', with: '-1'
    click_button '更新'

    expect(page).to have_css('header span.alert')
  end
end
