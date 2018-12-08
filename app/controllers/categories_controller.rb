class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update]

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result.includes(:operations)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to operations_path, notice: create_notice(action: 'create', model: 'category')
    else
      flash.now.alert = t('errors.sth_went_wrong')
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: create_notice(action: 'update', model: 'category')
    else
      flash.now.alert = t('errors.sth_went_wrong')
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
