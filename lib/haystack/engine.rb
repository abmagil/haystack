require 'simple_form'
require 'haml-rails'

module Haystack
  class Engine < ::Rails::Engine
    isolate_namespace Haystack
  end
end
