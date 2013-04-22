class AddDetailsToRefineryRegistrations < ActiveRecord::Migration
  def change
    add_column :refinery_registrations, :vegetarian, :boolean
    add_column :refinery_registrations, :muslim, :boolean
    add_column :refinery_registrations, :kosher, :boolean
    add_column :refinery_registrations, :dietary_other, :boolean
    add_column :refinery_registrations, :dietary_what, :string
    add_column :refinery_registrations, :accompagne_title, :string
    add_column :refinery_registrations, :accompagne_last_name, :string
    add_column :refinery_registrations, :accompagne_first_name, :string
    add_column :refinery_registrations, :accompagne_country, :string
    add_column :refinery_registrations, :accompagne_vegetarian, :boolean
    add_column :refinery_registrations, :accompagne_muslim, :boolean
    add_column :refinery_registrations, :accompagne_kosher, :boolean
    add_column :refinery_registrations, :accompagne_dietary_other, :boolean
    add_column :refinery_registrations, :accompagne_other_what, :string
  end
end
