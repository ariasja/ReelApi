class Post < ActiveRecord::Base

  validates :user_id, presence: true

  belongs_to :user
  has_many :likes

  reverse_geocoded_by :geo_lat, :geo_long


end
