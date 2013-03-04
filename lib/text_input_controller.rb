module BaristaMatic
  class TextInputController

    Deject self
    dependency(:outstream) { STDOUT }

    attr_reader :machine

    def initialize(machine)
      @machine = machine.with_output_presenter{|machine| TextOutputPresenter.new(machine)}
    end

    def startup
      outstream.puts @machine.output_startup
    end

    def parse_line(line)
      case line.strip

      when 'r', 'R'
        machine.restock!(machine.full_shipment)
        outstream.puts machine.output_status

      when lambda {|drink_number| (1..machine.drink_types_count) === drink_number.to_i}
        drink_name = machine.get_drink_from_menu(line.to_i).human_name
        if machine.dispense_drink!(line.to_i)
          outstream.puts "Dispensing: #{drink_name}\n" + machine.output_status
        else
          outstream.puts "Out of stock: #{drink_name}\n" + machine.output_status
        end

      when ""
        # nothing to do yay

      when 'Q', 'q'
        throw :exit

      else
        outstream.puts "Invalid selection: #{line}\n" + machine.output_status
      end

    end

    def parse_input(input)
      catch(:exit) do
        input.each_line do |line|
          parse_line(line.chomp)
        end
      end
    end


  end
end
