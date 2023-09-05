class SettingsController < ApplicationController
  before_action :set_setting, only: %i[ show edit update destroy ]

  # GET /settings or /settings.json
  def index
    if user_signed_in?
      @settings = Setting.where(userid: [current_user.id])
      if @settings.blank?
        redirect_to new_setting_path
        flash[:notice] = "Please update your settings"
      else
        @settings = Setting.where(userid: [current_user.id])
      end

      @male = Barangay.where(gender: 'male').count
      if @male == 0
        @male = ''
        @maledis = 'd-none'
      else
        @male
        @maledis = 'd-block'
      end
      @female = Barangay.where(gender: 'female').count
      if @female == 0
        @female = ''
        @femaledis = 'd-none'
      else
        @female 
        @femaledis = 'd-block'
      end
      @total = Barangay.count
      if @total == 0
        @total = ''
        @totaldis = 'd-none'
      else
        @total
        @totaldis = 'd-block'
      end
      @inbox = Chat.count
      if @inbox == 0
        @inbox = ''
      else
        @inbox
      end
    else
      redirect_to new_user_session_path
    end
  end


  # GET /settings/1 or /settings/1.json
  def show
    if user_signed_in?
      @male = Barangay.where(gender: 'male').count
      if @male == 0
        @male = ''
        @maledis = 'd-none'
      else
        @male
        @maledis = 'd-block'
      end
      @female = Barangay.where(gender: 'female').count
      if @female == 0
        @female = ''
        @femaledis = 'd-none'
      else
        @female 
        @femaledis = 'd-block'
      end
      @total = Barangay.count
      if @total == 0
        @total = ''
        @totaldis = 'd-none'
      else
        @total
        @totaldis = 'd-block'
      end
      @inbox = Chat.count
      if @inbox == 0
        @inbox = ''
      else
        @inbox
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /settings/new
  def new
    if user_signed_in?
      @settings = Setting.where(userid: [current_user.id])
      if @settings.blank?
        @setting = Setting.new
      else
        redirect_to settings_path
      end

      @male = Barangay.where(gender: 'male').count
      if @male == 0
        @male = ''
        @maledis = 'd-none'
      else
        @male
        @maledis = 'd-block'
      end
      @female = Barangay.where(gender: 'female').count
      if @female == 0
        @female = ''
        @femaledis = 'd-none'
      else
        @female 
        @femaledis = 'd-block'
      end
      @total = Barangay.count
      if @total == 0
        @total = ''
        @totaldis = 'd-none'
      else
        @total
        @totaldis = 'd-block'
      end
      @inbox = Chat.count
      if @inbox == 0
        @inbox = ''
      else
        @inbox
      end
    else
      redirect_to new_user_session_path
    end
    
  end

  # GET /settings/1/edit
  def edit
    if user_signed_in?
      @settings = Setting.where(userid: [current_user.id])
      if @settings.blank?
        redirect_to new_setting_path
        flash[:notice] = "Please update your settings"
      else
        @settings = Setting.where(userid: [current_user.id])
      end

      @male = Barangay.where(gender: 'male').count
      if @male == 0
        @male = ''
        @maledis = 'd-none'
      else
        @male
        @maledis = 'd-block'
      end
      @female = Barangay.where(gender: 'female').count
      if @female == 0
        @female = ''
        @femaledis = 'd-none'
      else
        @female 
        @femaledis = 'd-block'
      end
      @total = Barangay.count
      if @total == 0
        @total = ''
        @totaldis = 'd-none'
      else
        @total
        @totaldis = 'd-block'
      end
      @inbox = Chat.count
      if @inbox == 0
        @inbox = ''
      else
        @inbox
      end
    else
      redirect_to new_user_session_path
    end
  end

  # POST /settings or /settings.json
  def create
    if user_signed_in?
      @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to setting_url(@setting), notice: "Setting was successfully created." }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /settings/1 or /settings/1.json
  def update
    if user_signed_in?
      respond_to do |format|
        if @setting.update(setting_params)
          format.html { redirect_to setting_url(@setting), notice: "Setting was successfully updated." }
          format.json { render :show, status: :ok, location: @setting }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # DELETE /settings/1 or /settings/1.json
  def destroy
    if user_signed_in?
      @setting.destroy

    respond_to do |format|
      format.html { redirect_to settings_url, notice: "Setting was successfully destroyed." }
      format.json { head :no_content }
    end
    else
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def setting_params
      params.require(:setting).permit(:userid, :firstname, :middlename, :lastname, :phonenumber, :twiliophonenumber, :auth_token, :account_sid)
    end
end
