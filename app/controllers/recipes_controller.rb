class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe_types = RecipeType.all
    @recipe = Recipe.new
  end

  def create
    @recipe_types = RecipeType.all
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] ='Você deve informar todos os dados da receita'
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe_types = RecipeType.all
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe_types = RecipeType.all
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method)
  end
end
