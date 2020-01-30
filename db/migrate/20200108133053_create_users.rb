class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string "username", :limit => 50, :null => false
      t.string "email", :limit => 50, :null => false
      t.integer "admin_access", :default => 0
      t.column "password", :string, :limit => 20, :null => false
      t.timestamps
    end
  end
end
