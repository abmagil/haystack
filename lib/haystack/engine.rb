
module Haystack
  class Engine < ::Rails::Engine
    isolate_namespace Haystack
    config.autoload_paths += %W(#{Rails.root}/app/searchers)
  end
end
