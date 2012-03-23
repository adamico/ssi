class CreateLinksLinks < ActiveRecord::Migration

  def up
    create_table :refinery_links do |t|
      t.string :title
      t.string :url
      t.integer :link_category_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-links"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/links/links"})
    end

    drop_table :refinery_links

  end

end
