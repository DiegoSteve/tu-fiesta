class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[ show edit update destroy ]
  

  # GET /events or /events.json
  def index
    if params[:search].present?
      @events = current_user.events.where('LOWER(name) LIKE ?', "%#{params[:search].downcase}%")
      puts "SE ENCONTRÓ"
    else
      @events = current_user.events
      puts "NO SE ENCONTRÓ"
    end
  end

  def homepage
  end

  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
    @guests = @event.guests
    @current_user = current_user 
    if @event.caducado?
      flash.now[:notice] = 'Este evento ha caducado.'
    else
      flash.now[:notice] = 'Este evento está activo.'
    end

    @invitation = Invitation.new(event: @event)
    @event.guests.build if @event.guests.empty?
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
   
    respond_to do |format|
      if @event.save

        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :place, :date, :start_time, :end_time).merge(user_id: current_user.id)
    end
end
