class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  scope :active, -> { where(active: true) }
  scope :blocked, -> { where(active: false) }
  
  has_one_attached :user_image
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments, dependent: :destroy
  
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
    errors.add(:base, 'このアカウントはブロックされています。') unless active
  end
end

