module BaristaMatic
  class Drink

    Deject self # add dependency injection support

    dependency(:storage) { IngredientsStorage.get_instance("default_location") }

    attr_reader :type
    def initialize(type)
      @type = type
    end

    def cost
      ingredients.inject(0){|sum, ingredient| sum += ingredient.cost} 
    end

    def ingredients
      @ingredients ||= self.class.recipes[type].map do |ingredient_name, units|
        ingredient(ingredient_name, units)
      end
    end

    def ingredient(ingredient_name, units)
      RecipeIngredient.new(ingredient_name, units)
    end

    # this will lock the ingredients from the storage
    def in_stock?
      ingredients_hash = {}.tap do |hash| 
        ingredients.each{|ingredient| hash[ingredient.ingredient_name] = ingredient.units } 
      end
      storage.in_stock?(ingredients_hash)
    end

    def human_name
      type.gsub("_", " ").split(/(\W)/).map(&:capitalize).join
    end

    def self.all
      @all ||= recipes.keys.map do |drink_type|
        new(drink_type)
      end
    end

    # returns hash keyed off drink_type, with ingredients and their unit amounts
    # Example:
    # {coffee => {coffee => 3, sugar => 1, cream => 1}}
    def self.recipes
      @recipes ||= YAML.load_file(File.dirname(__FILE__) + '/../db/recipes.yml')
    end

  end
end
