class HomeController < ApplicationController
  def index
    @budget = Budget.order(created_at: :desc).first
    @entries = @budget&.budget_entries&.includes(:setting)
    @q = Operation.ransack(params[:q])
    @chart_data = ChartDataGenerator.new.generate
  end
end
