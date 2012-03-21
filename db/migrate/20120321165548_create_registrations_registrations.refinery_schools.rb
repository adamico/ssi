# This migration comes from refinery_schools (originally 3)
class CreateRegistrationsRegistrations < ActiveRecord::Migration

  def up
    create_table :refinery_registrations do |t|
      t.string :surname
      t.string :first_name
      t.string :title
      t.string :company
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.string :fax
      t.string :email
      t.date :arrival
      t.date :departure
      t.string :accompagne
      t.string :ip
      t.string :payment
      t.integer :amount
      t.string :payment_date
      t.integer :school_id
      t.string :state
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-registrations"})
    end

    drop_table :refinery_registrations

  end

end
