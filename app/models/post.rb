class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true

  scope :order_by_created_at, -> {order created_at: :desc}
  scope :load_data_post, ->{select("id, title, content, created_at, user_id").order created_at: :desc}
end
