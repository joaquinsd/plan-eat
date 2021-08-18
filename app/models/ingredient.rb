class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :product
  validates :product_id, presence: true
  def to_s
    product.name
  end

end
