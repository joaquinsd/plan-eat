class Product < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :recipes, through: :ingredients, dependent: :destroy

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy

  belongs_to :category

  def ing_amount
    ingredients.amount
  end

end
