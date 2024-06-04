class Post < ApplicationRecord
  has_one_attached :bean_image
  
  def get_image
    unless bean_image.attached?
      file_path = Rails.root.join('app/assets/images/bean.jpg')
      bean_image.attach(io: File.open(file_path), filename: 'bean.jpg', content_type: 'image/jpeg')
    end
    bean_image
  end
end
