module BaristaMatic
  class TextOutputPresenter

    attr_reader :machine
    def initialize(machine)
      @machine = machine
    end

    def startup
      status
    end

    def status
      inventory + "\n" + menu
    end

    def print(message)
      message
    end

    private
    def inventory
      output = "Inventory:\n"
      output << machine.inventory.map {|ingredient| 
        [ingredient.human_name, ingredient.units].join(",")
      }.join("\n")
    end

    def menu
      output = "Menu:\n"
      machine.menu.each_with_index{|drink, i|
        output << [i+1, drink.human_name, "$%.2f" % drink.cost, drink.in_stock?].join(",") + "\n"
      }
      output
    end

  end
end
