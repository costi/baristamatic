module BaristaMatic
  class RecipeIngredient
    attr_reader :ingredient_name, :units

    def initialize(ingredient_name, units)
      @ingredient_name = ingredient_name
      @units = units
    end

    def cost
      unit_cost * units
    end

    # returns a hash keyed off ingredient name, with value being cost
    # Example:
    # {sugar => 0.75} 
    def self.ingredients_costs
      YAML.load_file(File.dirname(__FILE__) + '')
    end

    def unit_cost
      self.class.ingredients_costs[ingredient_name].to_d
    end
  end
end
