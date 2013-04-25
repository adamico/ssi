class AddInvitedSpeakerToRefineryRegistrations < ActiveRecord::Migration
  def change
    add_column :refinery_registrations, :invited, :string
  end
end
