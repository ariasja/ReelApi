class Hashtag < ActiveRecord::Base
  belongs_to :post, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :post_id, presence: true
  validates :tag, presence: true
  validates :tagging_user_id, presence: true
end
