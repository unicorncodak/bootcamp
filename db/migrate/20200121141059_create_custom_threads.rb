class CreateCustomThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_threads do |t|
      t.string :title
      t.integer :project_id

      t.timestamps
    end
  end
end
