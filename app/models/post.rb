class Post < ApplicationRecord
  has_one_attached :bean_image
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  validates :bean_origin, presence: true
  validates :bean_roast, presence: true
  validates :bean_acidity, presence: true
  validates :bean_bitter, presence: true
  validates :bean_extraction, presence: true
  validates :bean_title, presence: true
  validates :bean_body, presence: true
  
  def self.search(query)
    where("bean_title LIKE ?", "%#{query}%")
  end
  
  def get_image
    if bean_image.attached?
      bean_image
    else
      attach_default_image
    end
  end

  private

  def attach_default_image
    file_path = Rails.root.join('app/assets/images/bean.jpg')
    bean_image.attach(io: File.open(file_path), filename: 'bean.jpg', content_type: 'image/jpeg')
    bean_image
  end
end
