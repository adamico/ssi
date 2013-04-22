class AddPricesToRefinerySchools < ActiveRecord::Migration
  def change
    add_column :refinery_schools, :early_bird_price, :integer
    add_column :refinery_schools, :accompagne_price, :integer
    add_column :refinery_schools, :early_bird_date, :date
  end
end
