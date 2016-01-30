class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :customer, null: false
      t.string :address, null: false            # メールアドレス
      t.string :address_for_index, null: false  # 索引用メールアドレス

      t.timestamps null: false
    end

    add_index :emails, :address_for_index, unique: true
    add_index :emails, :customer_id
    add_foreign_key :emails, :customers
  end
end
