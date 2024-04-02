class InvitationMailer < ApplicationMailer
    def send_invitation(invitation, event)
        @invitation = invitation
        @event = event
        @guest = invitation.guest
        @confirmation_link = confirm_invitation_url(invitation.invitation_token)
        mail(to: @guest.email, subject: "Invitación a Evento")
    end

    def confirmation_link(invitation)
      # Aquí generas el enlace utilizando alguna lógica específica de tu aplicación
      # Puedes utilizar el evento_path y la información necesaria de la invitación
      event_invitation_path(invitation.event, invitation)
    end  
end
