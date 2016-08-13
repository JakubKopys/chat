class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable
  has_ancestry
  validates :content, length: { maximum: 255, minimum: 4}
  has_attached_file :image, styles: { medium: "250>", thumb: "100x100>", lightbox: "1200>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validate :max_depth, on: :create

  # limits depth of comments.
  def max_depth
    if depth > 1
      errors.add(:parent_id, 'you can reply only on root comments')
    end
  end
end
