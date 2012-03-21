class CreateSchoolsSchools < ActiveRecord::Migration

  def up
    create_table :refinery_schools do |t|
      t.string :title
      t.date :starts_at
      t.date :ends_at
      t.string :place
      t.string :location
      t.integer :vignlieu_id
      t.integer :price
      t.date :deadline
      t.text :extranight
      t.string :theme
      t.string :sub_theme
      t.string :organiser
      t.string :sub_organizer
      t.text :award
      t.text :intro_program
      t.text :publication
      t.string :state
      t.date :registrations_start_at
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-schools"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/schools/schools"})
    end

    drop_table :refinery_schools

  end

end
