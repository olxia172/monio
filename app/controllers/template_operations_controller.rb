class TemplateOperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template_operation, only: [:show, :edit, :update, :destroy]

  def index
    @q = TemplateOperation.ransack(params[:q])
    @template_operations = @q.result.includes(:category, :account).sort { |a, b| a.paid_this_month == b.paid_this_month ? a.name <=> b.name : a.paid_this_month <=> b.paid_this_month }
  end

  def show; end

  def new
    @template_operation = TemplateOperation.new
  end

  def edit; end

  def create
    @template_operation = current_user.template_operations.new(template_operation_params)

    if @template_operation.save
      redirect_to template_operations_path,
        notice: create_notice(action: 'create', model: 'template_operation')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :new
    end
  end

  def update
    if @template_operation.update(template_operation_params)
      redirect_to template_operations_path,
        notice: create_notice(action: 'update', model: 'template_operation')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :edit
    end
  end

  def destroy
    if @template_operation.destroy
      redirect_to operations_path, notice: create_notice(action: 'delete', model: 'template_operation')
    else
      flash.now.alert = t('errors.sth_went_wrong')
    end
  end

  private

  def set_template_operation
    @template_operation = TemplateOperation.find(params[:id])
  end

  def template_operation_params
    params.require(:template_operation).permit(
      :value,
      :operation_type,
      :category_id,
      :user_id,
      :account_id,
      :target_account_id,
      :comment,
      :planned_at,
      :name
    )
  end
end
