class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = current_user.accounts.order(account_type: :asc)
  end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      redirect_to accounts_path, notice: 'You successfully created account'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'new'
    end
  end

  def show
    @operations = @account.operations.order(created_at: :desc)
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account), notice: 'You successfully updated your account'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
    end
  end

  def destroy
    if @account.destroy
      redirect_to accounts_path, notice: 'You successfully deleted account'
    else
      flash.now.alert = 'Something went wrong.'
    end
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :account_type)
  end
end
