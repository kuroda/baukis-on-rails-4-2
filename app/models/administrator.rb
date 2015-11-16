class Administrator < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder
end
