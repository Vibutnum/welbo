class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  validates :name, :password, :presence => true
  validates :email, :presence => true, :uniqueness =>true
  has_many  :microposts,  dependent: :destroy
  has_many  :comments
  has_many  :relationships, foreign_key: "follower_id",  dependent: :destroy
  has_many :reverse_relationships, foreign_key:  "followed_id",
                                   class_name:  'Relationship',
                                   dependent: :destroy
  has_many  :followers, through: :reverse_relationships, source: :follower
  has_many  :followed_users, through: :relationships, source: :followed


  def User.new_remember_token
    SecureRandom.urlsafe_base64

  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.where(followed_id: other_user.id).first
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.where(followed_id: other_user.id).first.destroy
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end