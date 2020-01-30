class AlterCommentTableAgain < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :thread_id, :custom_thread_id
  end
end
