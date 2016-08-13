class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  validates :content, length: { maximum: 1000, minimum: 10}
  has_attached_file :image, styles: { medium: "550x450>", thumb: "100x100>", lightbox: "1200>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
