class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :read
      t.integer :write
      t.integer :update
      t.integer :delete

      t.timestamps
    end
  end
end
