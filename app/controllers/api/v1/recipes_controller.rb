class Api::V1::RecipesController < Api::V1::ApiController

    def index
      titles = []
      if params[:status].present?
        @recipes = Recipe.where("status LIKE ?","1")
      else
        @recipes = Recipe.all
      end
      @recipes.each do |recipe|
        titles << recipe.title
      end
      render json: titles, status: 302
    end

	  def create
	    @recipe = Recipe.new(recipe_params)
	    if @recipe.save
	      render json: recipe_to_json, status: :created
	    else
	      render json: "Receita não cadastrada. \n #{@recipe.errors.full_messages}", status: 412
	    end
	  end

    def destroy
      @recipe = Recipe.find(params[:id])
     render json: "A receita #{@recipe.title} foi deletada.", status: 200 if @recipe.delete

   rescue ActiveRecord::RecordNotFound
     render json: "Receita não encontrada.", status: 404
    end

    def accepted
      @recipe = Recipe.find(params[:id])
      if !@recipe.admin?(@recipe.user)
      return render json: "Acesso NEGADO!", status: 401
      end
      @recipe.accepted!
      render json: "A receita #{@recipe.title} foi aceita!", status: 202 if @recipe.accepted?
      render json: "Não foi possivel aceitar a receita #{@recipe.title}", status: 304 if !@recipe.accepted?
    rescue ActiveRecord::RecordNotFound
      render json: "Receita não encontrada.", status: 404
    end

    def rejected
      @recipe = Recipe.find(params[:id])
      if !@recipe.admin?(@recipe.user)
      return render json: "Acesso NEGADO!", status: 401
      end
      @recipe.rejected!
      render json: "A receita #{@recipe.title} foi rejeitada!", status: 200 if @recipe.rejected?
      render json: "Não foi possivel rejeitar a receita #{@recipe.title}", status: 304 if !@recipe.rejected?
    rescue ActiveRecord::RecordNotFound
      render json: "Receita não encontrada.", status: 404
    end

end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty,
     :cook_time, :ingredients, :cook_method, :user_id)
  end
  def recipe_to_json
	    @recipe.to_json(except: [:user_id, :recipe_type_id], include: [:recipe_type, :user])
    end
