class Tag < ActiveRecord::Base
  has_many :message_tag_links, dependent: :destroy
  has_many :messages, through: :message_tag_links
end
