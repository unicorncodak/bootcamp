class AlterTeamColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :read, :read_access
    rename_column :teams, :write, :write_access
    rename_column :teams, :update, :update_access
    rename_column :teams, :delete, :delete_access
  end
end
