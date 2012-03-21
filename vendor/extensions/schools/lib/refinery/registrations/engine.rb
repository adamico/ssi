module Refinery
  module Registrations
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Registrations

      engine_name :refinery_schools

      initializer "register refinerycms_registrations plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "registrations"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.registrations_admin_registrations_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/registrations/registration',
            :title => 'surname'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Registrations)
      end
    end
  end
end
