class ChangeEventsTitleType < ActiveRecord::Migration
  def up
    change_column :refinery_events, :title, :text
  end

  def down
    change_column :refinery_events, :title, :string
  end
end
