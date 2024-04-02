class AddConfirmedToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :confirmed, :boolean
  end
end
