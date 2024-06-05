class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_one_attached :user_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  def get_image
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/coffee.jpg')
      user_image.attach(io: File.open(file_path), filename: 'coffee.jpg', content_type: 'image/jpeg')
    end
    user_image
  end
end