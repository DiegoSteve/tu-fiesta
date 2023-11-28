class InvitationMailer < ApplicationMailer
    def send_invitation(invitation)
        @invitation = invitation
        @event = invitation.event
        @guest = invitation.guest
        mail(to: @invitation.email, subject: 'Invitación a TuEvento')
    end
end
