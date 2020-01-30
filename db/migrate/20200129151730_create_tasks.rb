class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
