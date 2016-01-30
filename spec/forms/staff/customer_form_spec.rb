require 'rails_helper'

describe Staff::CustomerForm do
  def params(options)
    options[:emails] ||= {}
    options[:phones] ||= {}
    ActionController::Parameters.new(
      customer: attributes_for(:customer, options))
  end

  describe '顧客の新規登録' do
    let(:form) { Staff::CustomerForm.new }
    let(:email0) { attributes_for(:email) }
    let(:email1) { attributes_for(:email) }

    example 'メールアドレスを 2 個' do
      form.assign_attributes(params(emails: { '0' => email0, '1' => email1 }))

      expect(form.save).to be_truthy

      customer = Customer.order(:id).last
      expect(customer.emails.size).to eq(2)
      expect(customer.emails.order(:id)[0].address).to eq(email0[:address])
      expect(customer.emails.order(:id)[1].address).to eq(email1[:address])
    end

    example 'メールアドレスが重複して指定されたらエラー' do
      form.assign_attributes(params(emails: { '0' => email0, '1' => email0 }))

      expect(form.save).to be_falsey
      expect(form.customer.emails[0].errors.full_messages[0])
        .to eq('メールアドレスが重複しています。')
      expect(form.customer.emails[1].errors.full_messages[0])
        .to eq('メールアドレスが重複しています。')
    end

    example 'メールアドレスが重複して指定されたらエラー（大文字・小文字）' do
      email2 = email0.merge(address: email0[:address].upcase)
      form.assign_attributes(params(emails: { '0' => email0, '1' => email2 }))

      expect(form.save).to be_falsey
      expect(form.customer.emails[0].errors.full_messages[0])
        .to eq('メールアドレスが重複しています。')
      expect(form.customer.emails[1].errors.full_messages[0])
        .to eq('メールアドレスが重複しています。')
    end
  end

  describe '顧客情報の更新' do
    let(:customer) {
      create(:customer, emails: [
        build(:email, email0), build(:email, email1)
      ])
    }
    let(:form) { Staff::CustomerForm.new(customer) }
    let(:email0) { attributes_for(:email) }
    let(:email1) { attributes_for(:email) }

    example 'メールアドレスを交換する' do
      form.assign_attributes(params(emails: { '0' => email1, '1' => email0 }))

      expect(form.save).to be_truthy

      customer.reload
      expect(customer.emails[0].address).to eq(email1[:address])
      expect(customer.emails[0].address_for_index).to eq(email1[:address])
      expect(customer.emails[1].address).to eq(email0[:address])
      expect(customer.emails[1].address_for_index).to eq(email0[:address])
    end
  end
end
