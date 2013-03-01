require 'spec_helper'

describe BaristaMatic::IngredientsStorage do
  subject { described_class.get_instance("default_location") }

  before :each do
    described_class.stub(:locations).and_return(
      {
        "default_location" => {
          "quantities" => {
            "cocoa"         => 10,
            "coffee"        => 10,
            "cream"         => 10,
            "decaf_coffee"  => 10,
            "espresso"      => 10,
            "foamed_milk"   => 10,
            "steamed_milk"  => 10,
            "sugar"         => 10,
            "whipped_cream" => 10,
          }
        }
      }
    )
        
  end

  it 'has #initialize private' do
    expect{described_class.new}.to raise_error(NoMethodError)
  end

  it 'gets the default location as same object' do
    instance1 = described_class.get_instance("default_location")
    instance2 = described_class.get_instance("default_location")
    expect(instance1.object_id).to eql(instance2.object_id)
  end

end
