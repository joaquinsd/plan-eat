class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, dependent: :destroy

  has_many :recipe_menus, dependent: :destroy
  has_many :menus, through: :recipe_menus, dependent: :destroy
  accepts_nested_attributes_for :products, :allow_destroy => true
  accepts_nested_attributes_for :ingredients, :allow_destroy => true

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

  def favorite(user)
    Favorite.create(user: user, recipe: self)
  end

  def unfavorite(user)
    favorites.where(user: user).destroy_all
  end

  def favorited?(user)
    favorites.where(user: user).any?
  end

  def fav_toggler(user)
    if favorited?(user)
      unfavorite(user)
    else
      favorite(user)
    end
  end
end
