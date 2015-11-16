class AlterAddresses2 < ActiveRecord::Migration
  def change
    add_index :addresses, :postal_code
  end
end
