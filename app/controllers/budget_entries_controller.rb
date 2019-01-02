class BudgetEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget
  before_action :set_budget_entry, only: [:show, :edit, :update, :destroy]

  def index
    @budget_entries = if params[:budget_id].present?
                        @budget.budget_entries.includes(:setting)
                      else
                        BudgetEntry.all.includes(:setting)
                      end
  end

  def show
  end

  def new
    @budget_entry = Budget.budget_entries.new
  end

  def edit
  end

  def update
    if @budget_entry.update(budget_entry_params)
      redirect_to budget_budget_entries_path(@budget),
                  notice: create_notice(action: 'update', model: 'budget_entry')
    else
      flash.now.alert = t('errors.sth_went_wrong')
      render :edit
    end
  end

  def destroy
    if @budget_entry.destroy
      redirect_to budget_budget_entries_path(@budget), notice: create_notice(action: 'delete', model: 'budget_entry')
    else
      flash.now.alert = t('errors.sth_went_wrong')
    end
  end

  private

  def set_budget
    @budget = Budget.find(params[:budget_id])
  end

  def set_budget_entry
    @budget_entry = BudgetEntry.find(params[:id])
  end

  def budget_entry_params
    params.require(:budget_entry).permit!
  end
end
