class AddOldidToSchools < ActiveRecord::Migration
  def change
    add_column :refinery_schools, :oldid, :integer
  end
end
