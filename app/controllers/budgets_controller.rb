class BudgetsController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  def index
    @budgets = Budget.all
  end

  def show
    @entries = @budget.budget_entries.includes(:setting)
  end

  def new
    @budget = Budget.new
  end

  def edit
  end

  def create
    @budget = BudgetGenerator.new.generate

    if @budget.persisted?
      redirect_to @budget, notice: create_notice(action: 'create', model: 'budget')
    else
      flash.now.alert = t('errors.sth_went_wrong')
      render :new
    end
  end

  def update
    if @budget.update(budget_params)
      redirect_to @budget, notice: create_notice(action: 'update', model: 'budget')
    else
      flash.now.alert = t('errors.sth_went_wrong')
      render :edit
    end
  end

  def destroy
    if @budget.destroy
      redirect_to budgets_url, notice: create_notice(action: 'delete', model: 'budget')
    else
      flash.now.alert = t('errors.sth_went_wrong')
    end
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.permit(:budget)
  end
end
