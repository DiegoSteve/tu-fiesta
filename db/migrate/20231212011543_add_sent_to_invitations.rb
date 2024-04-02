class AddSentToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :sent, :boolean
  end
end
