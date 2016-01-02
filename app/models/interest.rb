class Interest < ActiveRecord::Base
  has_many :customer_interests
  has_many :customers, through: :customer_interests, autosave: true
  alias_attribute :interest_id, :id

  validates :title, presence: true, length: { maximum: 8, allow_blank: false }

  before_destroy :confirm_destroy_action

  protected
    def confirm_destroy_action
      # Only allow delete action when interests records number greater than 2
      Interest.count > 2
    end
end
