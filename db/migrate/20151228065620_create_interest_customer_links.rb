class CreateInterestCustomerLinks < ActiveRecord::Migration
  def change
    create_table :interest_customer_links do |t|
      t.references :interest, null: false
      t.references :customer, null: false
    end

    add_index :interest_customer_links, [ :interest_id, :customer_id ], unique: true
  end
end
