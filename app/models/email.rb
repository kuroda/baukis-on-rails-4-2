class Email < ActiveRecord::Base
  include StringNormalizer

  belongs_to :customer

  before_validation do
    self.address = normalize_as_email(address)
    self.address_for_index = address.downcase if address
  end

  validates :address, presence: true, email: { allow_blank: true }
  validates :address_for_index, uniqueness: { allow_blank: true }

  after_validation do
    if errors.include?(:address_for_index)
      errors.add(:address, :taken)
      errors.delete(:address_for_index)
    end
  end
end
