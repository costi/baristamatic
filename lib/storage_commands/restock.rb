module BaristaMatic
  module StorageCommands
    class Restock
      attr_reader :shipment
      
      # hash of item_name => quantity
      def initialize(shipment)
        @shipment = shipment 
      end

      # execute with storage details
      # returns the remaining shipment units, without changing the argument
      # storage is changed
      def execute(storage)
        Hash[shipment.map {|ingredient|
          ingredient_name, units_in_shipment = *ingredient
          units_to_transfer = [IngredientsStorage::MAX_CELL_CAPACITY-storage[ingredient_name].units, units_in_shipment].min
          storage[ingredient_name].units += units_to_transfer
          [ingredient_name, units_in_shipment - units_to_transfer]
        }]



      end
    end
  end
end
