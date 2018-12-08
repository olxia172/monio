class HomeController < ApplicationController
  def index
    @budget = Budget.order(created_at: :desc).first
    @entries = @budget&.budget_entries&.includes(:setting)
    @q = Operation.ransack(params[:q])
    @operations = @q.result.includes(:category).newest
  end
end
