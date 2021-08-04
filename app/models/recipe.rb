class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients, dependent: :destroy
end
