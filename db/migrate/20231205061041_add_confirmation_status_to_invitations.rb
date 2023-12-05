class AddConfirmationStatusToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :confirmation_status, :string
  end
end
