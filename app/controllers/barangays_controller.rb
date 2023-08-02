class BarangaysController < ApplicationController
  before_action :set_barangay, only: %i[ show edit update destroy ]

  # GET /barangays or /barangays.json
  def index
    if user_signed_in?
      @barangays = Barangay.all
      @male = Barangay.where(gender: 'male').count
      @female = Barangay.where(gender: 'female').count
      @total = Barangay.count
      @inbox = Chat.count

      if params[:query].present?
        @barangays = Barangay.where('fullname LIKE ?', "%#{params[:query]}%")
      else
        @barangays = Barangay.all
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /barangays/1 or /barangays/1.json
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

  # GET /barangays/new
  def new
    if user_signed_in?
      @barangay = Barangay.new
      @total = Barangay.count
      @male = Barangay.where(gender: 'male').count
      @female = Barangay.where(gender: 'female').count
      @total = Barangay.count
      @inbox = Chat.count
    else
      redirect_to new_user_session_path
    end
  end

  # GET /barangays/1/edit
  def edit
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

  # POST /barangays or /barangays.json
  def create
    if user_signed_in?
      @barangay = Barangay.new(barangay_params)

      respond_to do |format|
        if @barangay.save
          format.html { redirect_to barangay_url(@barangay), notice: "Barangay was successfully created." }
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
          format.html { redirect_to barangay_url(@barangay), notice: "Barangay was successfully updated." }
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
        format.html { redirect_to barangays_url, notice: "Barangay was successfully destroyed." }
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
