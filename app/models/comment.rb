class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :comment_body, presence: true
  
 validates :user_id, uniqueness: { scope: :post_id, message: "はこの投稿に対して既にコメントしています。" }
  
end
