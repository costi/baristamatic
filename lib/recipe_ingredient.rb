module BaristaMatic
  class RecipeIngredient
    attr_reader :ingredient_name
    attr_accessor :units

    def initialize(ingredient_name, units)
      @ingredient_name = ingredient_name
      @units = units
    end

    def cost
      unit_cost * units
    end

    def human_name
      ingredient_name.gsub("_", " ").split(/(\W)/).map(&:capitalize).join
    end

    # returns a hash keyed off ingredient name, with value being cost
    # Example:
    # {sugar => 0.75} 
    def self.ingredients_costs
      YAML.load_file(File.dirname(__FILE__) + '/../db/ingredients_costs.yml')
    end

    def unit_cost
      price = self.class.ingredients_costs[ingredient_name]
      raise "Cannot find price for #{ingredient_name}" unless price
      price.to_d
    end
  end
end
