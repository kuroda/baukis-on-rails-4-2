class Customer < ActiveRecord::Base
  include PersonalNameHolder
  include PasswordHolder

  has_many :emails, dependent: :destroy, autosave: true
  has_many :addresses, dependent: :destroy
  has_one :home_address, autosave: true
  has_one :work_address, autosave: true
  has_many :phones, dependent: :destroy
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },
    class_name: 'Phone', autosave: true
  has_many :entries, dependent: :destroy
  has_many :programs, through: :entries
  has_many :messages
  has_many :outbound_messages, class_name: 'CustomerMessage',
    foreign_key: 'customer_id'
  has_many :inbound_messages, class_name: 'StaffMessage',
    foreign_key: 'customer_id'

  before_validation do
    emails.each_with_index do |e0, i|
      emails.each_with_index do |e1, j|
        next if i == j || e0.address.blank?
        if e0.address.downcase == e1.address.try(:downcase)
          emails[i].duplicated = true
        end
        if e0.address.downcase == e1.address_was.try(:downcase)
          emails[i].exchanging = true
        end
      end
    end
  end

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(obj) { Date.today },
    allow_blank: true
  }

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end

  after_save do
    emails.map(&:resave!)
  end
end
