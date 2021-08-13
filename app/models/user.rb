class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :recipes, through: :favorites, dependent: :destroy

  has_many :user_menus, dependent: :destroy
  has_many :menus, through: :user_menus, dependent: :destroy

  def to_s
    name
  end

end
