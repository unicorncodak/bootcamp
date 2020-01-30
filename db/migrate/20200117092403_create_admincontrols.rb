class CreateAdmincontrols < ActiveRecord::Migration[6.0]
  def change
    create_table :admincontrols do |t|

      t.timestamps
    end
  end
end
