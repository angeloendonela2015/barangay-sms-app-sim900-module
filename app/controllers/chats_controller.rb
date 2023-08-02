class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    if user_signed_in?
      @users = User.all
      @chats = Chat.order(created_at: :desc)
      @total = Barangay.count
      @male = Barangay.where(gender: 'male').count
      @female = Barangay.where(gender: 'female').count
      @total = Barangay.count
      @inbox = Chat.count
    else
      redirect_to new_user_session_path
    end
  end

  # GET /chats/1 or /chats/1.json
  def show
    if user_signed_in?
      @total = Barangay.count
      @male = Barangay.where(gender: 'male').count
      @female = Barangay.where(gender: 'female').count
      @total = Barangay.count
      @inbox = Chat.count
    else
      redirect_to new_user_session_path
    end
  end

  # GET /chats/new
  def new
    if user_signed_in?
      @chat = Chat.new
      @total = Barangay.count
      @male = Barangay.where(gender: 'male').count
      @female = Barangay.where(gender: 'female').count
      @total = Barangay.count
      @inbox = Chat.count
    else
      redirect_to new_user_session_path
    end
  end

  # GET /chats/1/edit
  def edit
    if user_signed_in?
      @barangay = Barangay.new
      @male = Barangay.where(gender: 'male').count
      @female = Barangay.where(gender: 'female').count
      @total = Barangay.count
      @inbox = Chat.count
    else
      redirect_to new_user_session_path
    end
  end

  # POST /chats or /chats.json
  def create
    if user_signed_in?
      @chat = Chat.new(chat_params)

      respond_to do |format|
        
        if @chat.save
          phone_number = chat_params[:phone_number]
          message_body = chat_params[:body]
          # Initialize the Twilio client with your Twilio credentials.
          client = Twilio::REST::Client.new('AC322ce592b8e5e272cac0c844d4f21355', 'a41a0150b439843e25d1824f8e264553')
          #client = Twilio::REST::Client.new(ENV['AC322ce592b8e5e272cac0c844d4f21355'], ENV['a41a0150b439843e25d1824f8e264553'])
          # Send the SMS message using the Twilio API.
          client.messages.create(from: '+19894742612', to: phone_number, body: message_body)

          format.html { redirect_to chat_url(@chat), notice: "Message was successfully sent." }
          format.json { render :show, status: :created, location: @chat }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @chat.errors, status: :unprocessable_entity }
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
          format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
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
        format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
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
