class ApplicationSetting < ActiveRecord::Base
  validates :application_name, presence: true,
    length: { within: 1..16, allow_blank: true }
  validates :session_timeout, numericality:
    { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
end
