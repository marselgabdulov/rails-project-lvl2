class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :user
end
