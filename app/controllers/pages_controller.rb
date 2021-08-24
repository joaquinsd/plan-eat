class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[profile]
  protect_from_forgery except: :profile
  def index
    respond_to do |format|
      if user_signed_in?
        @q = Recipe.ransack(params[:q])
        @recipes = @q.result
        format.html { render 'recipes/index' }
      else
        format.html { render :landing }
      end
    end
  end

  def landing
  end

  # GET /resource/profile
  def profile
    @recipe_favorites = Favorite.where(user_id: current_user.id).joins(:recipe)
    @ingredient_favorites = Favorite.where(user_id: current_user.id).joins(recipe: {ingredients: {product: :category}})
    @categories_chart = @recipe_favorites.group('recipes.category').count
    @ingredients_chart = @ingredient_favorites.group('categories.name').count
    respond_to do |format|
      format.js {  }
      format.html {}
    end
  end

  def favorites
    @favorites = Favorite.where(user_id: current_user.id).includes(:recipe)
  end

  def orders
    @orders_pending = Order.where("user_id = ? and status != ?",current_user.id, 'completed').includes(:order_items)
    @orders_completed = Order.where("user_id = ? and status = ?",current_user.id, 'completed').includes(:order_items)

  end
end
