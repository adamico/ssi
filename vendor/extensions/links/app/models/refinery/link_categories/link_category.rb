module Refinery
  module LinkCategories
    class LinkCategory < Refinery::Core::BaseModel
      self.table_name = 'refinery_link_categories'      
    
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true
      has_many :links, class_name: "::Refinery::Links::Link"
    end
  end
end
