module Refinery
  module LinkCategories
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::LinkCategories

      engine_name :refinery_links

      initializer "register refinerycms_link_categories plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "link_categories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.link_categories_admin_link_categories_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/link_categories/link_category'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::LinkCategories)
      end
    end
  end
end
