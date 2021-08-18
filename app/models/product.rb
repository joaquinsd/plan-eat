class Product < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :recipes, through: :ingredients, dependent: :destroy

  belongs_to :category

  def ing_amount
    ingredients.amount
  end

end
