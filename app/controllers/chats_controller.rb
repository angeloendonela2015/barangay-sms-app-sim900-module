class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    if user_signed_in?
      @barangays = Barangay.all
      @users = User.all

      @q = Chat.ransack(params[:q])
      @chats = @q.result(distinct: true).page(params[:page]).per(50)

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
    else
      redirect_to new_user_session_path
    end
  end

  # GET /chats/1/edit
  def edit
    if user_signed_in?
      @barangay = Barangay.new
      @barangays = Barangay.all
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

  # POST /chats or /chats.json
  def create
    if user_signed_in?
      @chat = Chat.new(chat_params)
      @barangays = Barangay.all
      @settings = Setting.where(userid: [current_user.id])

      @settings.each do |deviceSetting|
        @devicePort = "/dev/#{deviceSetting.auth_token}"
        @deviceBaud = 19200
      end

      begin
        
        sp = SerialPort.new(@devicePort, @deviceBaud)
        if @settings.blank?
          redirect_to new_setting_path
          flash[:notice] = "Please update your settings"
        else
            
          respond_to do |format|
            if @chat.save
              mobileNumber = chat_params[:phone_number]
              messageContent = chat_params[:body]

              # Serialport Connection
              sp = SerialPort.new(@devicePort, @deviceBaud, 8, 1, SerialPort::NONE)
              # Send commands to Arduino
              commandAT = ("#{mobileNumber}, #{messageContent}\0x1A")
              sleep(10)
              sp.write("#{commandAT}\n")
              sleep(10)
              sp.write(26.chr)
              sp.close

              format.html { redirect_to chat_url(@chat), notice: "Your message was successfully sent." }
              format.json { render :show, status: :created, location: @chat }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @chat.errors, status: :unprocessable_entity }
            end
    
          end
        end
      rescue Errno::ENOENT
        flash[:notice] = "Device not found please check port connections!"
        redirect_to root_path
      rescue => e
        flash[:notice] = "An error occured: #{e.message}"
        redirect_to root_path
      ensure
        sp.close if sp && !sp.closed?
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
