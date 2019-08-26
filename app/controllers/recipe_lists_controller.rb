class RecipeListsController < ApplicationController
  before_action :authenticate_user! , only: %i[ new create show index]

  def index
    @recipe_lists = RecipeList.where("user_id == ?", "#{current_user.id}")
  end

  def show
    @recipe_list = RecipeList.find(params[:id])
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(list_params)
    @recipe_list.user = current_user
    if @recipe_list.save
      redirect_to @recipe_list
    else
      flash.now[:alert] = "Não foi possível criar lista de receitas"
      render :new
    end
  end

  private
  def list_params
    params.require(:recipe_list).permit(:name)
  end
end
