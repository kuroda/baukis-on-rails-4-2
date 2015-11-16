require 'rails_helper'

describe Customer::SessionsController do
  describe '#create' do
    let(:customer) { create(:customer, password: 'password') }

    example '「次回から自動でログインする」にチェックせずにログイン' do
      post :create, customer_login_form: {
        email: customer.email,
        password: 'password'
      }

      expect(session[:customer_id]).to eq(customer.id)
      expect(response.cookies['customer_id']).to be_nil
    end

    example '「次回から自動でログインする」にチェックしてログイン' do
      post :create, customer_login_form: {
        email: customer.email,
        password: 'password',
        remember_me: '1'
      }

      expect(session[:customer_id]).to be_nil
      expect(response.cookies['customer_id']).to match(/[0-9a-f]{40}\z/)

      cookies = response.request.env['action_dispatch.cookies']
        .instance_variable_get(:@set_cookies)
      expect(cookies['customer_id'][:expires]).to be > 19.years.from_now
    end
  end
end
