class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :comment_body, presence: true
  
  # １投稿につき１個コメント
  validates :post_id, uniqueness: { scope: :user_id, message: "You have already commented on this post." }
  
end
