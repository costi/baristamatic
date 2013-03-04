module BaristaMatic
  class Machine
    Deject self
    dependency(:output) { |machine| TextOutput.new(machine) }
    dependency(:storage) { IngredientsStorage.get_instance }

    def inventory
      storage.find_all.sort_by{|ingredient| ingredient.human_name}
    end

    def menu
      Drink.all.sort_by{|drink| drink.human_name}
    end

    def startup_output
      output.startup
    end

  end
end
