class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
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
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted a recipe"
  end

  private
    def recipe_params
      params.required(:recipe).permit(:title, :description, :image)
    end

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end
end
