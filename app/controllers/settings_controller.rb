class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_setting, only: [:edit, :update, :destroy]

  def index
    @settings = Setting.all
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      redirect_to settings_path, notice: 'You successfully created new setting type'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'new'
    end
  end

  def edit; end

  def update
    if @setting.update(setting_params)
      redirect_to settings_path, notice: 'You successfully updated setting settings'
    else
      flash.now.alert = 'Something went wrong. Check if all fields are properly completed'
      render 'edit'
    end
  end

  def destroy
    if @setting.destroy
      redirect_to settings_path, notice: 'You successfully deleted setting setting'
    else
      flash.now.alert = 'Something went wrong'
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:name, category_ids: [])
  end

  def set_setting
    @setting = Setting.find(params[:id])
  end
end
