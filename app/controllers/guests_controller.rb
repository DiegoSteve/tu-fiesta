class GuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_guest, only: %i[ show edit update destroy ]

  # GET /guests or /guests.json
  def index
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
      @guests = @event.guests
      puts "ENTRO"
    else
      @guests = current_user.guests
    end
    
    if params[:search].present?
      search_query = "%#{params[:search].downcase}%"
      @guests = @guests.where('LOWER(guests.name) LIKE ? OR LOWER(guests.email) LIKE ? OR LOWER(guests.telephone) LIKE ?',
                        search_query, search_query, search_query)
      puts "SE ENCONTRÓ"
    else
      puts "NO SE ENCONTRÓ"
    end
  end

  # GET /guests/1 or /guests/1.json
  def show
    @guest = Guest.find(params[:id])
    @event = @guest.event if @guest # Accediendo al evento asociado con el invitado
  end

  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
    @event = @guest.event # Obtén el evento asociado al invitado
  end

  # POST /guests or /guests.json
  def create
    @guest = Guest.new(guest_params)

    respond_to do |format|
      if @guest.save
        format.html { redirect_to guest_url(@guest), notice: "Guest was successfully created." }
        format.json { render :show, status: :created, location: @guest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guests/1 or /guests/1.json
  def update
    respond_to do |format|
      if @guest.update(guest_params)
        format.html { redirect_to guest_url(@guest), notice: "Guest was successfully updated." }
        format.json { render :show, status: :ok, location: @guest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1 or /guests/1.json
  def destroy
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to guests_url, notice: "Guest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guest_params
      params.require(:guest).permit(:name, :email, :telephone, :kinship, :table, :event_id)
    end
end
