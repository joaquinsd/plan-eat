class Menu < ApplicationRecord
  has_many :recipe_menus, dependent: :destroy
  has_many :recipes, through: :recipe_menus, dependent: :destroy

  has_many :user_menus, dependent: :destroy
  has_many :users, through: :user_menus, dependent: :destroy

  accepts_nested_attributes_for :recipe_menus, allow_destroy: true
  accepts_nested_attributes_for :recipes, allow_destroy: true
end
