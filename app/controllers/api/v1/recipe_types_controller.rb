class Api::V1::RecipeTypesController < Api::V1::ApiController

	#before_action :authenticate_user! , only: %i[create]
	before_action :verify_admin, only: %i[create]

	  def create
	    @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
	    if @recipe_type.save
	      render json: @recipe_type, status: :created
	    else
	      render json: @recipe_type.errors.full_messages, status: 412
	    end
	  end

	  def show
	    @recipe_type = RecipeType.find(params[:id])
	    render json: @recipe_type.to_json(include: :recipes), status: 200
	  end
	end

	private

		def verify_admin
			if current_user
		    render json: 'NEGADO', status: 401 unless current_user.admin?
			else
				render json: 'NEGADO', status: 401 
			end
	  end
