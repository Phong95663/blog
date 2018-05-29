class Post < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true

  scope :order_by_created_at, -> {order created_at: :desc}
end
