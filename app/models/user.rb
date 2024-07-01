class User < ApplicationRecord
  scope :active, -> { where(status: true) }
  scope :blocked, -> { where(status: false) }
  
  has_one_attached :user_image
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy  
  
  
  # フォロー関係
  has_many :follower_relationships, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followee_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followees, through: :followee_relationships, source: :followee

  def following?(user)
    followees.include?(user)
  end

  def follow(user)
    followees << user unless following?(user)
  end

  def unfollow(user)
    followees.delete(user) if following?(user)
  end
  
  
  
  validate :active_user, on: :create
  
  def get_image
    if user_image.attached?
      user_image
    else
      attach_default_image
    end
  end
  
  def attach_default_image
    file_path = Rails.root.join('app/assets/images/coffee.jpg')
    user_image.attach(io: File.open(file_path), filename: 'coffee.jpg', content_type: 'image/jpeg')
    user_image
  end
  
  def private_account?
    is_private
  end
  
  private
  
 def active_user
  errors.add(:base, 'このアカウントはブロックされています。') unless status
 end
 
 
end

