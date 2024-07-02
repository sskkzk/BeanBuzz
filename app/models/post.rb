class Post < ApplicationRecord
  has_one_attached :bean_image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :bean_origin, presence: true
  validates :bean_roast, presence: true
  validates :bean_acidity, presence: true
  validates :bean_bitter, presence: true
  validates :bean_extraction, presence: true
  validates :bean_title, presence: true
  validates :bean_body, presence: true
  
  def self.search(search)
    if search
      where('bean_title LIKE ? OR bean_body LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
  
  def get_image
    if bean_image.attached?
      bean_image
    else
      attach_default_image
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def favorited_by?(user)
    user.present? && favorites.exists?(user_id: user.id)
  end


  private

  def attach_default_image
    file_path = Rails.root.join('app/assets/images/bean.jpg')
    bean_image.attach(io: File.open(file_path), filename: 'bean.jpg', content_type: 'image/jpeg')
    bean_image
  end
end
