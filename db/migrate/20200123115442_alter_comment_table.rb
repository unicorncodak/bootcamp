class AlterCommentTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :project_id, :thread_id
  end
end
