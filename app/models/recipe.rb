class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, dependent: :destroy

  has_many :recipe_menus, dependent: :destroy
  has_many :menus, through: :recipe_menus, dependent: :destroy
  accepts_nested_attributes_for :products, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  ratyrate_rateable 'name'

  validates_presence_of :name, :description, :steps, :picture, :ingredients

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
    favorites.where(user: user).includes(:recipes).any?
  end

  def fav_toggler(user)
    if favorited?(user)
      unfavorite(user)
    else
      favorite(user)
    end
  end

  def add_to_menu(menu)
    RecipeMenu.create(recipe: self, menu: menu)
  end

  def delete_from_menu(menu)
    recipe_menus.where(menu: menu).destroy_all
  end

  def included_menu?(menu)
    recipe_menus.where(menu: menu).any?
  end

  def menu_toggler(menu)
    if included_menu?(menu)
      delete_from_menu(menu)
    else
      add_to_menu(menu)
    end
  end

  def rate(value, user)
    Rating.create(recipe: self, user: user, rating: value)
  end

end
