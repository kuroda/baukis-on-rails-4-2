class Email < ActiveRecord::Base
  include StringNormalizer

  belongs_to :customer

  attr_writer :exchanging

  before_validation do
    if address
      self.address_for_index = if @exchanging
        address.downcase.gsub(/@/, '%')
      else
        address.downcase
      end
    end
  end

  validates :address, presence: true, email: { allow_blank: true }
  validates :address_for_index, uniqueness: { allow_blank: true }

  attr_writer :duplicated
  validate do
    errors.add(:address, :duplicated) if @duplicated
  end

  after_validation do
    if errors.include?(:address_for_index)
      errors.add(:address, :taken)
      errors.delete(:address_for_index)
    end
  end

  def address=(address)
    self[:address] = normalize_as_email(address)
  end

  def resave!
    if @exchanging
      @exchanging = false
      save!
    end
  end
end
