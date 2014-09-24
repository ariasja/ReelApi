class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes

  reverse_geocoded_by :geo_lat, :geo_long


end
