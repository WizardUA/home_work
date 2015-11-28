class Item < ActiveRecord::Base

  has_attached_file :item_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :item_image, content_type: /\Aimage\/.*\Z/

  validates :price, numericality: { greater_than: 0, allow_nil: true }
  validates :name, presence: true

  has_many :positions
  has_many :carts, through: :positions

end
