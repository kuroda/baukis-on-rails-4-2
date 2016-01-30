class AlterCustomers3 < ActiveRecord::Migration
  def change
    remove_column :customers, :email
    remove_column :customers, :email_for_index
  end
end
