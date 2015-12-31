class InterestCustomerLink < ActiveRecord::Base
  belongs_to :customer
  belongs_to :interest
end
