module BaristaMatic
  module StorageCommands
    class RestockIngredients
      attr_reader :shipment
      
      # hash of item_name => quantity
      def initialize(shipment)
        @shipment = shipment 
      end

      # execute with storage details
      def execute(storage)
        Hash[shipment.map {|ingredient|
          ingredient_name, units_in_shipment = *ingredient
          units_to_transfer = [IngredientsStorage::MAX_CELL_CAPACITY, units_in_shipment].min
          storage[ingredient_name] += units_to_transfer
          [ingredient_name, units_in_shipment - units_to_transfer]
        }]



      end
    end
  end
end
