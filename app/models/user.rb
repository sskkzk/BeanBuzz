class User < ApplicationRecord
  scope :active, -> { where(status: true) }
  scope :blocked, -> { where(status: false) }
  
  has_one_attached :user_image
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy  
  
  # フォローしているユーザーとの関連
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followees, through: :active_follows, source: :followee

  # フォローされているユーザーとの関連
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower
  
  def following?(other_user)
    followees.include?(other_user)
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
  
  private
  
 def active_user
  errors.add(:base, 'このアカウントはブロックされています。') unless status
 end
end

