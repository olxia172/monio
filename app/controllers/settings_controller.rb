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
      redirect_to settings_path, notice: create_notice(action: 'create', model: 'setting')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :new
    end
  end

  def edit; end

  def update
    if @setting.update(setting_params)
      redirect_to settings_path, notice: create_notice(action: 'update', model: 'setting')
    else
      flash.now.alert = t('errors.sth_went_wrong_with_form')
      render :edit
    end
  end

  def destroy
    if @setting.destroy
      redirect_to settings_path, notice: create_notice(action: 'delete', model: 'setting')
    else
      flash.now.alert = t('errors.sth_went_wrong')
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
