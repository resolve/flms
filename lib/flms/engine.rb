module Flms
  class Engine < ::Rails::Engine
    require 'active_model_serializers'

    isolate_namespace Flms
  end
end
