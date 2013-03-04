Given /^a fully stocked baristamatic$/ do
  # This should work by default with the default config
end

When /^I start the machine$/ do
  @machine = BaristaMatic::Machine.new
end

Then /^I get the following output:$/ do |string|
  @machine.startup_output.should == string
end
