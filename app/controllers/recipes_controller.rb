class RecipesController < ApplicationController
  before_action :load_type, only: %i[new edit]
  before_action :authenticate_user! , only: %i[ new create my ]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
      if current_user
        @recipe_lists = current_user.recipe_lists
        @recipe_list_item = RecipeListItem.new
      end
  end

  def new
      @recipe = Recipe.new
  end

  def create
      @recipe = Recipe.new(recipe_params)
      @recipe.user_id = current_user.id
      if @recipe.save
        redirect_to @recipe
      else
        load_type
        flash.now[:alert] = "Não foi possível salvar a receita"
        render :new
      end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    redirect_to root_path if !@recipe.owner? current_user
  end

  def update
    @recipe = Recipe.find(params[:id])
    if  @recipe.update(recipe_params)
      redirect_to @recipe
    else
      load_type
      flash.now[:alert] = "Não foi possível salvar a receita"
      render :edit
    end
  end

  def search
    @recipes = Recipe.where("title LIKE ?","%#{params[:term]}%" )
    if @recipes.empty?
      flash[:alert] = 'Receita não encontrada'
    end
  end

  def my
    @recipes = Recipe.where("user_id == ?", "#{current_user.id}")
  end

  def add_to_list
    @recipe = Recipe.find(params[:id])
    recipe_list_item = RecipeListItem.new(params.require(:recipe_list_item).permit(:recipe_list_id))
    recipe_list_item.recipe_id = @recipe.id
    if recipe_list_item.save
      flash[:notice] = 'Adicionado a lista com sucesso'
      redirect_to @recipe
    else
      flash[:notice] = 'Não foi possivel adicionar à lista'
      redirect_to @recipe
    end
  end

  def remove_from_list
    recipe_list_item = RecipeListItem.find(params[:id])
    recipe_list = recipe_list_item.recipe_list_id
    recipe_list_item.destroy
    redirect_to root_path
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty,
     :cook_time, :ingredients, :cook_method, :profile)
  end

  def load_type
    @recipe_types = RecipeType.all
  end

end
