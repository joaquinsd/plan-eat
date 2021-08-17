class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :favorites, dependent: :destroy
  has_many :recipes, through: :favorites, dependent: :destroy

  has_many :user_menus, dependent: :destroy
  has_many :menus, through: :user_menus, dependent: :destroy

  def to_s
    name
  end

  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    return user if user
    user = User.where(email: auth.info.email).first
    return user if user
    User.create(
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.first_name,
      lastname: auth.info.last_name,
      profile_picture: auth.info.image,
      email: auth.info.email,
      password: Devise.friendly_token[0,20]
    )
  end
end
