class SettingsController < ApplicationController
  def index
    @settings = Setting.all
  end

  def create
    successful_saves = 0
    Setting.all.each do |setting|
      setting_param = params[:setting][setting.id.to_s]
      if setting_param
        setting.value = setting_param[:value] if setting_param      
        if setting.save
          successful_saves += 1
        end
      end
    end
    if successful_saves == Setting.count
      flash[:notice] = "Settings updated successfully."
    elsif successful_saves > 0
      flash[:error] = "#{successful_saves} settings were saved correctly, the rest were not."
    else
      flash[:error] = "Error saving all settings."
    end
    redirect_to :action => :index
  end

end
