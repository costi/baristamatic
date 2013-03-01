module BaristaMatic
  class Inventory
    class_attribute :inventories

    def self.inventories = {:default => }}
      inventories  
    end
    def self.get(location)
      inventories[location]
    end

    # quantities is an hash keyed off inventory_item, with value as quantity
    # Example:
    # {coffee => 10, sugar => 8}
    def initialize(quantities)

    end

  end
end
