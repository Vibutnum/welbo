class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id
  belongs_to :micropost
  belongs_to :user
  validates :body, presence: true
  default_scope -> { order('created_at DESC') }
end
