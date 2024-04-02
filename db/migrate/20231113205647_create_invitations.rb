class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :invitation_token

      t.timestamps
    end
  end
end
