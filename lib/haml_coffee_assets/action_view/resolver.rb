require "action_view"
require 'action_view/template/resolver'

module HamlCoffeeAssets
  module ActionView
    # Custom resolver to prevent Haml Coffee templates from being rendered by
    # Rails for non-HTML formats, since a template name without a MIME type
    # in it would normally be a fallback for all formats.
    #
    class Resolver < ::ActionView::FileSystemResolver
      # (Needed to fork and update to hamle 1.16.1, internmatch is not updated)
      # https://github.com/internmatch/haml_coffee_assets/commit/202395f43bacd805ae9b17ced067810d54204426
      def find_templates(*args)
        details = args[3]
        if details[:formats].include?(:html)
          clear_cache if ::Rails.env == "development"
          super
        else
          []
        end
      end
    end
  end
end
