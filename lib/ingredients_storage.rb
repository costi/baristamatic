module BaristaMatic
  class IngredientsStorage
    attr_reader :ingredients # stores the current count of ingredients

    MAX_CELL_CAPACITY = 10

    def self.locations
      YAML.load_file(File.dirname(__FILE__) + "/../db/ingredients_storages.yml")
    end
    
    # I can have either an singleton instance that deals with a location
    # or multiple instances that deal with a location, but which have 
    # to deal with locking of the resources of that location and updating
    # the location storage
    # I'll just go with a singleton instance for now because it's simpler
    def self.location_instances
      @location_instances ||= {} # singleton per location_name
    end

    def self.load_location_status(name)
      locations[name]
    end

    def self.get_instance(location_name = "default_location")
      if location_status = load_location_status(location_name)
        location_instances[location_name] ||= new(location_status["quantities"])
      else
        raise ArgumentError, "no such storage location #{location_name}. Available locations: #{locations.keys.inspect}"
      end
    end

    def in_stock?(ingredient_quantities)
      ingredient_quantities.each do |ingredient_name, requested_units|
        if ingredient = find_ingredient(ingredient_name)
          return false unless ingredient.units >= requested_units
        else
          return nil
        end
      end
      true
    end

    # shipment is a hash with item_name => quantity
    # returns what remains of shipment
    def restock!(shipment)
      execute_command(:restock, shipment)
    end
 
    # recipe_order is a hash with item_name => quantity
    # NOM NOM
    # returns true or false
    def consume!(recipe_order)
      in_stock?(recipe_order) ? execute_command(:consume, recipe_order) : false
    end

    def execute_command(command, *args)
      StorageCommands.const_get(command.to_s.capitalize).new(*args).execute(ingredients)
    end
    private :execute_command


    def distinct_ingredients
      ingredients.keys
    end

    def find_all
      ingredients.values
    end

    # returns RecipeIngredient onject, which responds to ingredient_name and units
    def find_ingredient(ingredient_name)
      ingredients[ingredient_name]
    end
    private :find_ingredient

    # ingredient_quantities is an hash keyed off inventory_item, with value as quantity
    # Example:
    # {coffee => 10, sugar => 8}
    def initialize(ingredient_quantities)
      @ingredients = {}.tap do |hash|
        ingredient_quantities.each do |ingredient_name, units|
          hash[ingredient_name] = ingredient(ingredient_name, units)
        end
      end
      @ingredients.extend(Transaction::Simple)
      # I am implementing a command pattern to deal with the storage, and
      # I could roll back my own transactions, but it's way easier with
      # Transaction::Simple
    end
    private_class_method :new # don't be touching the initialize of my singleton!

    def ingredient(ingredient_name, units)
      RecipeIngredient.new(ingredient_name, units)
    end

  end
end
