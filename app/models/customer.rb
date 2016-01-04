class Customer < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

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
  has_many :customer_interests, autosave: true
  has_many :interests, through: :customer_interests

  JOB_TITLES = %w(
    会社員
    会社役員 公務員 自営業
    自由業 専業主婦・専業主夫
    パート・アルバイト 学生
    その他
  )

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(obj) { Date.today },
    allow_blank: true
  }
  validates :job_title, inclusion: { in: JOB_TITLES, allow_blank: true }

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end
end
