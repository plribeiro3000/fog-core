module Fog
  module Associations
    class Default
      attr_reader :model, :name, :aliases, :as

      def initialize(model, name, collection_name, options)
        @model = model
        @name = name
        model.associations[name] = collection_name
        @aliases = options.fetch(:aliases, [])
        @as = options.fetch(:as, name)
        create_setter
        create_getter
        create_aliases
        create_mask
      end

      def create_aliases
        Array(aliases).each do |alias_name|
          model.aliases[alias_name] = name
        end
      end

      def create_mask
        model.masks[name] = as
      end
    end
  end
end