class AddJobTitleToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :job_title, :string
  end
end
