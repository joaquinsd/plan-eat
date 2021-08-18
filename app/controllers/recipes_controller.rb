class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy favorite]

  # GET /recipes or /recipes.json
  def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @response = @recipe.recipe_data
    respond_to do |format|
      format.html {}
      format.js {}
      format.json {}
    end
    # render json: JSON.generate(response)
  end


  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def favorite
    @recipe.fav_toggler(current_user)
    respond_to do |format|
      if @recipe.favorited?(current_user)
        format.html { redirect_to root_path, notice: 'Recipe Liked' }
      else
        format.html { redirect_to root_path, notice: 'Recipe Unliked' }
        format.js { redirect_to your_favorites_path}
      end
    end
  end

  def add_to_menu
    @menu = Menu.find(params[:id])
    @recipe.menu_toggler(@menu)
    respond_to do |format| 
      if @recipe.included_menu?(@menu)
        format.html { redirect_to root_path, notice: 'Recipe Added to Menu'}
      else
        format.html { redirect_to root_path, notice: 'Recipe Removed from Menu'}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :description, :steps, :picture, :category)
    end
end
