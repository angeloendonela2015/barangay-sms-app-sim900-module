class BarangaysController < ApplicationController
  before_action :set_barangay, only: %i[ show edit update destroy ]

  # GET /barangays or /barangays.json
  def index
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

      @q = Barangay.ransack(params[:q])
      @barangays = @q.result(distinct: true).page(params[:page]).per(50)

    else
      redirect_to new_user_session_path
    end
  end

  # GET /barangays/1 or /barangays/1.json
  def show
    if user_signed_in?
      @settings = Setting.where(userid: [current_user.id])
      if @settings.blank?
        redirect_to new_setting_path
        flash[:notice] = "Please update your settings"
      else
        @settings = Setting.where(userid: [current_user.id])
        @settings.each do |setting|
          @phonenumber = setting.phonenumber
          @twiliophonenumber = setting.twiliophonenumber
          @auth_token = setting.auth_token
          @account_sid = setting.account_sid
        end
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

  # GET /barangays/new
  def new
    if user_signed_in?
      @barangay = Barangay.new
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

  # GET /barangays/1/edit
  def edit
    if user_signed_in?
        @total = Barangay.count
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

  # POST /barangays or /barangays.json
  def create
    if user_signed_in?
      @barangay = Barangay.new(barangay_params)
      respond_to do |format|
        if @barangay.save
          format.html { redirect_to barangay_url(@barangay), notice: "Barangay list was successfully created." }
          format.json { render :show, status: :created, location: @barangay }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @barangay.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /barangays/1 or /barangays/1.json
  def update
    if user_signed_in?
      respond_to do |format|
        if @barangay.update(barangay_params)
          format.html { redirect_to barangay_url(@barangay), notice: "Barangay list was successfully updated." }
          format.json { render :show, status: :ok, location: @barangay }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @barangay.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # DELETE /barangays/1 or /barangays/1.json
  def destroy
    if user_signed_in?
      @barangay.destroy

      respond_to do |format|
        format.html { redirect_to barangays_url, notice: "Barangay list was successfully deleted." }
        format.json { head :no_content }
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barangay
      if user_signed_in?
        @barangay = Barangay.find(params[:id])
      else
        redirect_to new_user_session_path
      end
    end

    # Only allow a list of trusted parameters through.
    def barangay_params
      if user_signed_in?
        params.require(:barangay).permit(:fullname, :number, :address, :gender, :status)
      else
        redirect_to new_user_session_path
      end
    end
end
