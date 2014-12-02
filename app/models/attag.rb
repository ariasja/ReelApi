class Attag < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, foreign_key: "tagged_user"
  belongs_to :user, foreign_key: "tagging_user"
end
