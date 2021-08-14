class Product < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :recipes, through: :ingredients, dependent: :destroy

  def ing_amount
    ingredients.amount
  end

end
