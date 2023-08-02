class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    @chats = Chat.order(created_at: :desc)
    @total = Barangay.count
    @male = Barangay.where(gender: 'male').count
    @female = Barangay.where(gender: 'female').count
    @total = Barangay.count
    @inbox = Chat.count
  end

  # GET /chats/1 or /chats/1.json
  def show
    @total = Barangay.count
    @male = Barangay.where(gender: 'male').count
    @female = Barangay.where(gender: 'female').count
    @total = Barangay.count
    @inbox = Chat.count
  end

  # GET /chats/new
  def new
    @chat = Chat.new
    @total = Barangay.count
    @male = Barangay.where(gender: 'male').count
    @female = Barangay.where(gender: 'female').count
    @total = Barangay.count
    @inbox = Chat.count
  end

  # GET /chats/1/edit
  def edit
    @barangay = Barangay.new
    @male = Barangay.where(gender: 'male').count
    @female = Barangay.where(gender: 'female').count
    @total = Barangay.count
    @inbox = Chat.count
  end

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)

    respond_to do |format|

      begin
        # Your Twilio API call to send SMS
        # Replace ACCOUNT_SID, AUTH_TOKEN, and TWILIO_PHONE_NUMBER with your actual Twilio credentials
        client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
        client.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: phone_number,
          body: message
        )
      rescue Twilio::REST::RestError => e
        Rails.logger.error "Twilio Error: #{e.message}"
        return false
      end
  
      true


      if @chat.save
        phone_number = chat_params[:phone_number]
        message_body = chat_params[:body]
          # Initialize the Twilio client with your Twilio credentials.
          #client = Twilio::REST::Client.new('AC322ce592b8e5e272cac0c844d4f21355', 'a41a0150b439843e25d1824f8e264553')
          client = Twilio::REST::Client.new(ENV['AC322ce592b8e5e272cac0c844d4f21355'], ENV['a41a0150b439843e25d1824f8e264553'])
          # Send the SMS message using the Twilio API.
          client.messages.create(from: '+19894742612', to: phone_number, body: message_body)

          format.html { redirect_to chat_url(@chat), notice: "Message was successfully sent." }
          format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:name_chat, :phone_number, :body)
    end
end
