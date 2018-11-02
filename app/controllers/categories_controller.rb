class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to operations_path, notice: 'You successfully created new category'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
