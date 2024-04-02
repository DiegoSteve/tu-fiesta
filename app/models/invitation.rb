class Invitation < ApplicationRecord
    before_create :generate_invitation_token
    belongs_to :event
    belongs_to :guest, optional: true

    scope :unsent, -> { where(sent: false) }
    private

    def generate_invitation_token
        self.invitation_token = SecureRandom.urlsafe_base64
    end
end
