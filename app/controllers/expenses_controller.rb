class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:edit, :update, :destroy]

  def index
    @expenses = Expenses.all
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      redirect_to expenses_path, notice: 'You successfully created new expense type'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'new'
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'You successfully updated expense settings'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'edit'
    end
  end

  def destroy
    if @expense.destroy
      redirect_to expenses_path, notice: 'You successfully deleted expense setting'
    else
      flash.now.alert = 'Something went wrong'
    end
  end

  private

  def expense_params
    params.require(:expense).permit(category_ids: [])
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end
end
