class AddIntroRegistrationToRefinerySchools < ActiveRecord::Migration
  def change
    add_column :refinery_schools, :intro_registration, :text
  end
end
