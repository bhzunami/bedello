class WebsiteSettingsController < ApplicationController
	before_action :set_settings, only: [:show, :edit, :update]
  before_action :admin_user, only: [:show, :edit, :update]

  def show
  	@websiteSettings = WebsiteSettings.find(1)
  end

	def edit
		@websiteSettings = WebsiteSettings.find(1)
	end

	def update
		respond_to do |format|
      if @websiteSettings.update(settings_params)
        format.html { 
          redirect_to website_setting_path
          flash[:success] = "Einstellungen gespeichert" }
        	format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @websiteSettings.errors, status: :unprocessable_entity }
      end
    end

	end


	 private
    # Use callbacks to share common setup or constraints between actions.
    def set_settings
      @websiteSettings = WebsiteSettings.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def settings_params
      params.require(:website_settings).permit(:mailAddress, :webstoreOpen, :webstoreClose)
    end

end
