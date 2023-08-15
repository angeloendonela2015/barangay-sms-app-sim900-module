class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    if user_signed_in?
      @barangays = Barangay.all
      @users = User.all
      @chats = Chat.order(created_at: :desc)
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

  # GET /chats/1 or /chats/1.json
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

  # GET /chats/new
  def new
    if user_signed_in?
      @barangays = Barangay.all
      @chat = Chat.new
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

  # GET /chats/1/edit
  def edit
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

  # POST /chats or /chats.json
  def create
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

          @chat = Chat.new(chat_params)
          respond_to do |format|
            if @chat.save
              phonenumber = @phonenumber
              twiliophonenumber = @twiliophonenumber
              auth_token = @auth_token 
              account_sid = @account_sid
              phone_number = chat_params[:phone_number]
              message_body = "\n\n"
              message_body += chat_params[:body]
              message_body += "\n\n"
              message_body += "Reply to this number:"
              message_body += @phonenumber

              # Initialize the Twilio client with your Twilio credentials.
              client = Twilio::REST::Client.new(account_sid, auth_token)
              #client = Twilio::REST::Client.new(ENV['AC322ce592b8e5e272cac0c844d4f21355'], ENV['a41a0150b439843e25d1824f8e264553'])
              # Send the SMS message using the Twilio API.
              client.messages.create(from: twiliophonenumber, to: phone_number, body: message_body)
    
              format.html { redirect_to chat_url(@chat), notice: "Your message was successfully sent." }
              format.json { render :show, status: :created, location: @chat }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @chat.errors, status: :unprocessable_entity }
            end
    
          end


        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
      if user_signed_in?
      respond_to do |format|
        if @chat.update(chat_params)
          format.html { redirect_to chat_url(@chat), notice: "Your message was successfully updated." }
          format.json { render :show, status: :ok, location: @chat }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @chat.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    if user_signed_in?
      @chat.destroy

      respond_to do |format|
        format.html { redirect_to chats_url, notice: "Your message was successfully deleted." }
        format.json { head :no_content }
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      if user_signed_in?
        @chat = Chat.find(params[:id])
      else
        redirect_to new_user_session_path
      end
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      if user_signed_in?
        params.require(:chat).permit(:name_chat, :phone_number, :body)
      else
        redirect_to new_user_session_path
      end
    end
end
