class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.order(account_type: :asc)
  end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      redirect_to accounts_path, notice: create_notice(action: 'create', model: 'account')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :new
    end
  end

  def show
    @q = @account.operations.ransack(params[:q])
    @operations = @q.result.includes(:category).order(paid_at: :desc).page(params[:page]).per(params[:per])
    @categories = Category.all
    @operations_for_chart = @account.operations
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account), notice: create_notice(action: 'update', model: 'account')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :edit
    end
  end

  def destroy
    if @account.destroy
      redirect_to accounts_path, notice: create_notice(action: 'delete', model: 'account')
    else
      flash.now.alert = t('errors.sth_went_wrong')
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :account_type, :balance)
  end
end
