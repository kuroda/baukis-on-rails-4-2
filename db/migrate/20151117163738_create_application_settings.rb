class CreateApplicationSettings < ActiveRecord::Migration
  def change
    create_table :application_settings do |t|
      t.string :application_name, null: false
      t.integer :session_timeout

      t.timestamps null: false
    end
  end
end
