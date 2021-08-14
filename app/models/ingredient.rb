class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :product
  def to_s
    product.name
  end

end
