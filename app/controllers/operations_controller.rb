class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_operation, only: [:show, :edit, :update, :destroy]

  def index
    @q = Operation.ransack(params[:q])
    @operations = @q.result.includes(:category).order(created_at: :desc).page(params[:page]).per(params[:per])
    @categories = Category.all
  end

  def new
    @operation = Operation.new(operation_params)
  end

  def create
    @operation = current_user.operations.new(operation_params)

    if @operation.save
      redirect_to operations_path, notice: 'You successfully created operation'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'new'
    end
  end

  def edit; end

  def show; end

  def update
    if @operation.update(operation_params)
      redirect_to operations_path, notice: 'You successfully updated operation'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'edit'
    end
  end

  def destroy
    if @operation.destroy
      redirect_to operations_path, notice: 'You successfully deleted operation'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
    end
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.fetch(:operation, {}).permit(:value,
                                      :operation_type,
                                      :category_id,
                                      :user_id,
                                      :account_id,
                                      :target_account,
                                      :comment,
                                      :paid_at)
  end
end
