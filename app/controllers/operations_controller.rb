class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_operation, only: [:show, :edit, :update, :destroy]
  before_action :set_template_operation, only: [:new]

  def index
    @q = Operation.ransack(params[:q])
    @operations = @q.result.includes(:category).order(created_at: :desc).page(params[:page]).per(params[:per])
    @categories = Category.all
  end

  def new
    @operation = if @template_operation.present?
                   @template_operation
                     .operations
                     .new(@template_operation.attributes.except('planned_at', 'name'))
                 else
                   Operation.new(operation_params)
                 end
    @operation.paid_at = Date.current
  end

  def create
    @operation = current_user.operations.new(operation_params)

    if @operation.save
      redirect_to operations_path, notice: create_notice(action: 'create', model: 'operation')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @operation.update(operation_params)
      redirect_to operations_path, notice: create_notice(action: 'update', model: 'operation')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :edit
    end
  end

  def destroy
    if @operation.destroy
      redirect_to operations_path, notice: create_notice(action: 'delete', model: 'operation')
    else
      flash.now.alert = t('errors.sth_went_wrong')
    end
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end  

  def set_template_operation
    @template_operation = TemplateOperation.find(params[:template_operation_id]) if params[:template_operation_id].present?
  end

  def operation_params
    params.fetch(:operation, {}).permit(
      :value,
      :operation_type,
      :category_id,
      :user_id,
      :account_id,
      :target_account_id,
      :comment,
      :paid_at,
      :template_operation_id
    )
  end
end
