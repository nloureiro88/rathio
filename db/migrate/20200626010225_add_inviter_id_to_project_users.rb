class AddInviterIdToProjectUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :project_users, :inviter_id, :integer
  end
end
