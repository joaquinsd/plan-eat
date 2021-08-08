class PagesController < ApplicationController
  def index
    respond_to do |format|
      if user_signed_in?
        @recipes = Recipe.all
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
  end
end
