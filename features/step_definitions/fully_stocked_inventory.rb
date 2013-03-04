Given /^a fully stocked baristamatic$/ do
  # This should work by default with the default config
end

When /^I start the machine$/ do
  @machine = BaristaMatic::Machine.new
  @outstream = StringIO.new
  @controller = BaristaMatic::TextInputController.new(@machine).with_outstream(@outstream)
  @controller.startup
end

Then /^I get the following output:$/ do |string|
  @controller.outstream.rewind
  @controller.outstream.read.should == string
  @controller.outstream.truncate(0)
  @controller.outstream.rewind
end

When /^I input the following commands:$/ do |string|
  @controller.parse_input(string)
end


Given /^a started, fully stocked baristamatic$/ do
  @machine = BaristaMatic::Machine.new
  @outstream = StringIO.new
  @controller = BaristaMatic::TextInputController.new(@machine).with_outstream(@outstream)
  @controller.startup
  @controller.outstream.truncate(0)
  @controller.outstream.rewind
end
