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
      redirect_to @budget, notice: 'Budget was successfully created.'
    else
      render :new
    end
  end

  def update
    if @budget.update(budget_params)
      redirect_to @budget, notice: 'Budget was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_url, notice: 'Budget was successfully destroyed.'
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.permit(:budget)
  end
end
