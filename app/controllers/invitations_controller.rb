class InvitationsController < ApplicationController
  before_action :set_event, only: [:create]

  def create
    @event = Event.find(params[:event_id])
    @guest = Guest.find(params[:invitation][:guest_id])

    @invitation = @event.invitations.new(invitation_params)

    if @invitation.save
      InvitationMailer.send_invitation(@invitation, @event).deliver_now
      flash[:success] = "Invitación enviada correctamente."
      redirect_to @event
    else
      flash.now[:error] = "Error al enviar la invitación."
      render 'events/show'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def invitation_params
    params.require(:invitation).permit(:guest_id, :confirmation_status)
  end
end
