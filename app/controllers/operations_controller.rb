class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_operation, only: [:show, :edit, :update, :destroy]

  def index
    @operations = current_user.operations
  end

  def new
    @operation = Operation.new
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
  end

  def destroy
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:value, :operation_type, :category_id, :source_account_id, :target_account_id, :comment)
  end
end
