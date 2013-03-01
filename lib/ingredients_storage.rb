module BaristaMatic
  class IngredientsStorage

    def self.locations
      YAML.load_file()
    end
    
    # I can have either an singleton instance that deals with a location
    # or multiple instances that deal with a location, but which have 
    # to deal with locking of the resources of that location and updating
    # the location storage
    # I'll just go with a singleton instance for now because it's simpler
    @location_instances = {} # singleton per location_name
    def self.get_instance(location_name = "default_location")
      if location_name = locations[location_name]
        location_instances[location_name] ||= new(location[:quantities])
      else
        raise ArgumentError, "no such storage location #{location_name}. Available locations: #{locations.keys.inspect}"
      end
    end

    # ingredient_quantities is an hash keyed off inventory_item, with value as quantity
    # Example:
    # {coffee => 10, sugar => 8}
    def initialize(ingredient_quantities)
      @ingredients = ingredient_quantities.map do |ingredient_name, units|
        RecipeIngredient.new(ingredient_name, units)
      end
    end

    private_class_method :new

  end
end
