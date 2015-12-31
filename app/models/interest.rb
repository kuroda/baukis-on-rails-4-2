class Interest < ActiveRecord::Base
  has_and_belongs_to_many :customers, join_table: 'interest_customer_links'

  validates :title, presence: true, length: { maximum: 8, allow_blank: false }

  before_destroy :confirm_destroy_action

  protected
    def confirm_destroy_action
      # Only allow delete action when interests records number greater than 2
      Interest.count > 2
    end
end
