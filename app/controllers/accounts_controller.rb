class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      redirect_to accounts_path, notice: 'You successfully created account'
    else
      flash.now.alert = "Something went wrong. Check if all fields are properly completed"
      render 'new'
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :account_type)
  end
end
