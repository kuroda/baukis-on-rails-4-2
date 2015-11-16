class UpdatePhones1 < ActiveRecord::Migration
  def up
    execute(%q{
      UPDATE phones SET last_four_digits = 
        SUBSTR(number_for_index, LENGTH(number_for_index) - 3)
        WHERE number_for_index IS NOT NULL AND LENGTH(number_for_index) >= 4
    })
  end

  def down
    execute(%q{
      UPDATE phones SET last_four_digits = NULL
    })
  end
end
