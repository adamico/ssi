# This migration comes from refinery_links (originally 2)
class CreateLinkCategoriesLinkCategories < ActiveRecord::Migration

  def up
    create_table :refinery_link_categories do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-link_categories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/link_categories/link_categories"})
    end

    drop_table :refinery_link_categories

  end

end
