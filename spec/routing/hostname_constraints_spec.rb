require 'rails_helper'

describe 'ルーティング' do
  example '職員トップページ' do
    expect(get: 'http://baukis.example.com').to route_to(
      host: 'baukis.example.com',
      controller: 'staff/top',
      action: 'index'
    )
  end

  example '管理者ログインフォーム' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
      host: 'baukis.example.com',
      controller: 'admin/sessions',
      action: 'new'
    )
  end

  example '顧客トップページ' do
    expect(get: 'http://example.com/mypage').to route_to(
      host: 'example.com',
      controller: 'customer/top',
      action: 'index'
    )
  end

  example 'ホスト名が対象外ならerrors/not_foundへ' do
    expect(get: 'http://foo.example.jp').to route_to(
      controller: 'errors',
      action: 'not_found'
    )
  end

  example '存在しないパスならerrors/not_foundへ' do
    expect(get: 'http://example.com/xyz').to route_to(
      controller: 'errors',
      action: 'not_found',
      anything: 'xyz'
    )
  end
end
