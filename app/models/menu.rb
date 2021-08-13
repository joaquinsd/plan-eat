class Menu < ApplicationRecord
  has_many :recipe_menus, dependent: :destroy
  has_many :recipes, through: :recipe_menus, dependent: :destroy

  has_many :user_menus, dependent: :destroy
  has_many :users, through: :user_menus, dependent: :destroy

end
