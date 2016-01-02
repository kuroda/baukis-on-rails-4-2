class CreateCustomerInterests < ActiveRecord::Migration
  def change
    create_table :customer_interests do |t|
      t.references :customer, null: false
      t.references :interest, null: false
    end

    add_index :customer_interests, [ :customer_id, :interest_id ], unique: true
  end
end

