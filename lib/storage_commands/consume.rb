module BaristaMatic
  module StorageCommands
    class Consume
      attr_reader :recipe_order
      
      # hash of item_name => quantity
      def initialize(recipe_order)
        @recipe_order = recipe_order 
      end

      # execute with storage details
      # storage is changed
      def execute(storage)
        begin
          storage.start_transaction
          recipe_order.each do |ingredient_name, units_required|
            if storage[ingredient_name].units <= units_required
              raise "Not enough units!"
            else
              storage[ingredient_name].units -= units_required
            end
          end
        rescue
          storage.abort_transaction
          false
        else
          storage.commit_transaction
          true
        end
      end

    end
  end
end
