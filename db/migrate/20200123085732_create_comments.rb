class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
