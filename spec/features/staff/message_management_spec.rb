require 'rails_helper'

feature 'メッセージ管理機能' do
  include FeaturesSpecHelper
  include PerformanceSpecHelper
  let(:staff_member) { create(:staff_member) }
  let!(:root_message) { create(:customer_message, subject: 'Hello') }
  let!(:reply1) { create(:staff_message, parent: root_message) }
  let!(:message1) { create(:customer_message, parent: reply1) }
  let!(:message2) { create(:customer_message, parent: reply1) }
  let!(:reply2) { create(:staff_message, parent: message1) }
  let!(:reply3) { create(:staff_message, parent: message1) }
  let!(:message3) { create(:customer_message, parent: reply3) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario 'メッセージツリーの表示', :performance do |example|
    visit staff_message_path(message1)
    expect(page).to have_css('h1', text: 'メッセージ詳細')
    expect(page).to have_css('li a', text: 'Hello')

    elapsed = Benchmark.realtime do
      100.times do
        visit staff_message_path(message1)
      end
    end

    write_to_performance_log(example, elapsed)
    expect(elapsed).to be < 100.0
  end
end
