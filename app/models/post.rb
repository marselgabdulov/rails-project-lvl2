class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :user
  has_many :post_comments
  validates :title, presence: true
  validates :body, presence: true
end
