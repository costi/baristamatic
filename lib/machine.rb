module BaristaMatic
  class Machine
    Deject self
    dependency(:output_presenter) { |machine| TextOutputPresenter.new(machine) }
    dependency(:storage) { IngredientsStorage.get_instance }

    def inventory
      storage.find_all.sort_by{|ingredient| ingredient.human_name}
    end

    def menu
      Drink.all.sort_by{|drink| drink.human_name}
    end

    def output_startup
      output_presenter.startup
    end

    def output_status
      output_presenter.status
    end

    def drink_types_count
      Drink.all.size
    end

    def restock!(shipment)
      storage.restock!(shipment)
    end
    
    def get_drink_from_menu(drink_number)
      drink = menu[drink_number-1]
    end

    def dispense_drink!(drink_number)
      drink = get_drink_from_menu(drink_number)
      # TODO maybe we want to add another step here that actually dispenses the drink for a real coffee machine :)
      storage.consume!(drink.to_hash)
    end

    # helper method that might go away in production. We don't have access to full shipment
    def full_shipment
      Hash[storage.distinct_ingredients.map{|ingredient| [ingredient, storage.class::MAX_CELL_CAPACITY]}]
    end

  end
end
