class User < ActiveRecord::Base

  has_many :posts

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }


end
