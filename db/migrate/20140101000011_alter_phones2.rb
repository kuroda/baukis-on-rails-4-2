class AlterPhones2 < ActiveRecord::Migration
  def change
    add_column :phones, :last_four_digits, :string

    add_index :phones, :last_four_digits
  end
end
