class Interest < ActiveRecord::Base
  has_and_belongs_to_many :customers

  validates :title, presence: true, length: { maximum: 8, allow_blank: false }
end
