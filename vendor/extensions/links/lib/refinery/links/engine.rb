module Refinery
  module Links
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Links

      engine_name :refinery_links

      initializer "register refinerycms_links plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "links"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.links_admin_links_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/links/link'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Links)
      end
    end
  end
end
