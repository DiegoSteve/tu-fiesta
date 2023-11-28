class Invitation < ApplicationRecord
    before_create :generate_invitation_token

    private

    def generate_invitation_token
        self.invitation_token = SecureRandom.urlsafe_base64
    end
end