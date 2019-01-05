class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
    @goals = Goal.all
  end

  def show
  end

  def new
    @goal = current_user.goals.new
  end

  def edit
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to @goal, notice: create_notice(action: 'create', model: 'goal')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :new
    end
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: create_notice(action: 'update', model: 'goal')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :edit
    end
  end

  def destroy
    if @goal.destroy
      redirect_to goals_url, notice: create_notice(action: 'delete', model: 'goal')
    else
      flash.now.alert = t('errors.sth_went_wrong')
    end
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :final_value, :template_operation_id, :account_id, :paid_value)
  end
end
