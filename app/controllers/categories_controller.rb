class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.includes(:operations)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to operations_path, notice: 'You successfully created new category'
    else
      flash.now.alert = t('errors.sth_went_wrong')
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
