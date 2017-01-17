class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :upvote, :downvote, :myrecipes]

  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def myrecipes
    @recipes = current_user.recipes.order('created_at DESC')
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe && @recipe.save
      redirect_to @recipe, notice: "Successfully created a recipe!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe && @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Successfully updated recipe!"
    else
      render 'edit'
    end
  end

  def destroy
    if current_user == @recipe.user
      @recipe.destroy
      redirect_to root_path, notice: "Successfully deleted a recipe"
    else
      render @recipe, notice: "You cannot delete this post, please log in with the correct account."
    end
  end

  def upvote
    @recipe.vote_by :voter => current_user, vote: 'like'
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @recipe.vote_by :voter => current_user, vote: 'bad'
    respond_to do |format|
      format.js
    end
  end

  private
    def recipe_params
      params.required(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy],
                                                                    instructions_attributes: [:id, :step, :_destroy])
    end

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end
end
