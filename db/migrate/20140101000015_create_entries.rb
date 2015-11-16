class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :program, null: false
      t.references :customer, null: false
      t.boolean :approved, null: false, default: false # 承認済みフラグ
      t.boolean :canceled, null: false, default: false # 取り消しフラグ

      t.timestamps
    end

    add_index :entries, [ :program_id, :customer_id ], unique: true
    add_index :entries, :customer_id
    add_foreign_key :entries, :programs
    add_foreign_key :entries, :customers
  end
end
