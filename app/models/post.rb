class Post < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  validates :content, length: { maximum: 255, minimum: 10}
  has_attached_file :image, styles: { medium: "550x450>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
