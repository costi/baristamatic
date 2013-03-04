module BaristaMatic
  class Recipe

    # returns hash keyed off drink_type, with ingredients and their unit amounts
    # Example:
    # {coffee => {coffee => 3, sugar => 1, cream => 1}}
    def self.all
      @all ||= YAML.load_file(File.dirname(__FILE__) + '../db/recipes.yml')
    end

    def self.find(name)
      new(all[name])
    end

    def to_a

    end
  end
end
