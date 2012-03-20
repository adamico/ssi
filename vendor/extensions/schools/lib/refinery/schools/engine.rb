module Refinery
  module Schools
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Schools

      engine_name :refinery_schools

      initializer "register refinerycms_schools plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "schools"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.schools_admin_schools_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/schools/school'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Schools)
      end
    end
  end
end
