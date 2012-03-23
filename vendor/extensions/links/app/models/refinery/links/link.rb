module Refinery
  module Links
    class Link < Refinery::Core::BaseModel
      self.table_name = 'refinery_links'      
    
      acts_as_indexed :fields => [:title, :url]

      validates :title, :presence => true, :uniqueness => true
      belongs_to :link_category, class_name: "::Refinery::LinkCategories::LinkCategory"

      def self.uncategorized
        where(:link_category_id => nil)
      end

      delegate :title, to: :link_category, allow_nil: true, prefix: true

      def category_name
        link_category ? link_category_title : "uncategorized"
      end
    end
  end
end
