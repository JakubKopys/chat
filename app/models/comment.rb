class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable
  validates :content, length: { maximum: 255, minimum: 4}
end
