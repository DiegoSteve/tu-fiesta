class InvitationMailer < ApplicationMailer
    def send_invitation(invitation, event)
        @invitation = invitation
        @event = event
        @guest = invitation.guest
        mail(to: @guest.email, subject: "Invitación a Evento")
      end
end
