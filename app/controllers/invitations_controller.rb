class InvitationsController < ApplicationController
  def create
    @event = Event.find(params[:invitation][:event_id])
    @invitation = @event.invitations.new(invitation_params)
    
    if @invitation.save
      # Envía el correo electrónico de invitación
      InvitationMailer.send_invitation(@invitation).deliver_now
      flash[:success] = "Invitación enviada correctamente."
      redirect_to @event
    else
      flash.now[:error] = "Error al enviar la invitación."
      render 'events/show'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:guest_name, :guest_email, :confirmation_status)
  end
end
