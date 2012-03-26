class AddOldidToRefineryLinkCategory < ActiveRecord::Migration
  def change
    add_column :refinery_link_categories, :oldid, :integer

  end
end
