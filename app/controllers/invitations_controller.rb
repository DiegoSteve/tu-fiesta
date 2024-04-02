class InvitationsController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @current_user = current_user
    
    @event.guests.each do |guest|
      next if Invitation.exists?(event: @event, guest: guest, sent: true)

      @invitation = @event.invitations.new(
        guest_id: guest.id,
      )

      if @invitation.save
        @confirmation_link = confirm_invitation_url(@invitation.invitation_token)
        InvitationMailer.send_invitation(@invitation, @event).deliver_now
        @invitation.update(sent: true)
      else
        flash.now[:error] = "Error al enviar la invitación a #{guest.name}."
        render 'events/show'
        return
      end
    end

    flash[:success] = "Invitaciones enviadas correctamente."
    redirect_to @event
  end

  def confirm
    @invitation = Invitation.find_by(invitation_token: params[:id])

    if @invitation
      # Actualiza el estado de confirmación o realiza las acciones necesarias
      @invitation.update(confirmed: true)
      flash[:success] = "¡Asistencia confirmada correctamente!"
    else
      flash[:error] = "Error al confirmar la asistencia. El enlace puede ser inválido."
    end

    redirect_to root_path
  end

  def confirm_attendance
    @invitation = Invitation.find_by(invitation_token: params[:invitation_token])

    if @invitation && !@invitation.confirmed
      # Realiza las acciones necesarias para confirmar la asistencia
      @invitation.update(confirmed: true)
      flash[:success] = "¡Asistencia confirmada correctamente!"
      puts "SI FUNCIONA EL CONFIRM ATTENDANCE"
    else
      flash[:error] = "Error al confirmar la asistencia. El enlace puede ser inválido o la asistencia ya ha sido confirmada."
    end

    redirect_to root_path
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def invitation_params
    params.require(:invitation).permit(:guest_id)
  end
end
