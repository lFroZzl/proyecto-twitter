class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :friends

  def is_following?(friend_id)
    self.friends.where(:friend_id => friend_id).exists?
  end

  def arr_friends_id
    friends.map(&:friend_id)
    #friends.pluck(:friend_id)
  end


end
