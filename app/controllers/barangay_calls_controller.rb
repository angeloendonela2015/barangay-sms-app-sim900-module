class BarangayCallsController < ApplicationController
  before_action :set_barangay_call, only: %i[ show edit update destroy ]

  # GET /barangay_calls or /barangay_calls.json
  def index
    if user_signed_in?
      @barangay_calls = BarangayCall.order(created_at: :desc)
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
      @calls = BarangayCall.count
      if @calls == 0
        @calls = ''
      else
        @calls
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /barangay_calls/1 or /barangay_calls/1.json
  def show
    if user_signed_in?
      @barangay_calls = BarangayCall.all
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
      @calls = BarangayCall.count
      if @calls == 0
        @calls = ''
      else
        @calls
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /barangay_calls/new
  def new
    if user_signed_in?
      @barangay_call = BarangayCall.new
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
      @calls = BarangayCall.count
      if @calls == 0
        @calls = ''
      else
        @calls
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /barangay_calls/1/edit
  def edit
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
      @calls = BarangayCall.count
      if @calls == 0
        @calls = ''
      else
        @calls
      end
    else
      redirect_to new_user_session_path
    end
  end

  # POST /barangay_calls or /barangay_calls.json
  def create
    if user_signed_in?
      @settings = Setting.where(userid: [current_user.id])
      if @settings.blank?
        redirect_to new_setting_path
        flash[:notice] = "Please update your settings"
      else
        @settings = Setting.where(userid: [current_user.id])
          @settings.each do |setting|
          @twiliophonenumber = setting.twiliophonenumber
          @auth_token = setting.auth_token
          @account_sid = setting.account_sid

          @barangay_call = BarangayCall.new(barangay_call_params)
          respond_to do |format|
            if @barangay_call.save
              
              myNumber = @twiliophonenumber
              nameCall = barangay_call_params[:name_call]
              phoneCall = barangay_call_params[:phone_number]

              # Create a Twilio client
              client = Twilio::REST::Client.new(@account_sid, @auth_token)

              # Initiate the call
              call = client.calls.create( from: myNumber, to: phoneCall, url: 'http://demo.twilio.com/docs/voice.xml')

              # Output the call SID to the console (optional)
              puts "Call SID: #{call.sid}"

              format.html { redirect_to barangay_call_url(@barangay_call), notice: "Barangay call was successfully created." }
              format.json { render :show, status: :created, location: @barangay_call }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @barangay_call.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /barangay_calls/1 or /barangay_calls/1.json
  def update
    if user_signed_in?
      respond_to do |format|
        if @barangay_call.update(barangay_call_params)
          format.html { redirect_to barangay_call_url(@barangay_call), notice: "Barangay call was successfully updated." }
          format.json { render :show, status: :ok, location: @barangay_call }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @barangay_call.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # DELETE /barangay_calls/1 or /barangay_calls/1.json
  def destroy
    if user_signed_in?
      @barangay_call.destroy

      respond_to do |format|
        format.html { redirect_to barangay_calls_url, notice: "Barangay call was successfully deleted." }
        format.json { head :no_content }
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barangay_call
      @barangay_call = BarangayCall.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def barangay_call_params
      params.require(:barangay_call).permit(:name_call, :phone_number)
    end
end
