class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients, dependent: :destroy

  def json_ingredients
    all_ingredients = []
    ingredients.includes(:product).each do |ingredient|
      ingredient_hash = {}
      ingredient_hash[:id] = ingredient.id
      ingredient_hash[:name] = ingredient.product.name
      ingredient_hash[:measure] = ingredient.measure
      ingredient_hash[:amount] = ingredient.amount
      all_ingredients << ingredient_hash
    end
    all_ingredients
  end

  def recipe_data
    response = {}
    response[:id] = id
    response[:name] = name
    response[:description] = description
    response[:ingredients] = json_ingredients
    response[:steps] = steps
    response
  end
end
