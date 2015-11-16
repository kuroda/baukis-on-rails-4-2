require 'rails_helper'

describe Admin::TopController, 'ログイン前' do
  let(:administrator) { create(:administrator) }

  describe 'IPアドレスによるアクセス制限' do
    before do
      Rails.application.config.baukis[:restrict_ip_addresses] = true
    end

    example '許可' do
      AllowedSource.create!(namespace: 'admin', ip_address: '0.0.0.0')
      get :index
      expect(response).to render_template('admin/top/index')
    end

    example '拒否' do
      AllowedSource.create!(namespace: 'admin', ip_address: '192.168.0.*')
      get :index
      expect(response).to render_template('errors/forbidden')
    end
  end
end

describe Admin::TopController, 'ログイン後' do
  let(:administrator) { create(:administrator) }

  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#index' do
    example '通常はstaff/top/dashboardを表示' do
      get :index
      expect(response).to render_template('admin/top/dashboard')
    end

    example '停止フラグがセットされたら強制的にログアウト' do
      administrator.update_column(:suspended, true)
      get :index
      expect(session[:administrator_id]).to be_nil
      expect(response).to redirect_to(admin_root_url)
    end

    example 'セッションタイムアウト' do
      session[:last_access_time] =
        Staff::Base::TIMEOUT.ago.advance(seconds: -1)
      get :index
      expect(session[:administrator_id]).to be_nil
      expect(response).to redirect_to(admin_login_url)
    end
  end
end
