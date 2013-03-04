require 'spec_helper'

describe BaristaMatic::IngredientsStorage do
  subject { described_class.get_instance("default_location") }

  before :each do
    described_class.location_instances.clear # or else it will examples will bleed side effects to to others
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
            "steamed_milk"  => 0,
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

  describe '#find_item' do
    it 'finds storage items by name' do
      item = subject.instance_eval{ find_ingredient("cocoa") }
      item.ingredient_name.should == "cocoa"
      item.units.should == 10
    end

    it 'returns nil if the item does not exist' do
      subject.instance_eval{find_ingredient("unobtanium")}.should == nil
    end

    it 'returns the item if the existing item count is zero' do
      item = subject.instance_eval{ find_ingredient("steamed_milk") }
      item.ingredient_name.should == "steamed_milk"
    end
  end

  describe "#in_stock?" do
    it 'returns nil if the ingredient does not exist' do
     subject.in_stock?("coffee" => 4, "unobtanium" => 9001).should be_nil
    end

    it 'returns false if the ingredient exists, but not enough of it' do
     subject.in_stock?("espresso" => 11, "coffee" => 4).should be_false
    end

    it 'returns true if the ingredient exits and there is enough of it' do
     subject.in_stock?("espresso" => 10, "coffee" => 4).should be_true
    end
  end

  describe 'restocking' do
    it 'restocks to back to max values' do
      full_stock = Hash[subject.distinct_ingredients.map{|ingredient| [ingredient, subject.class::MAX_CELL_CAPACITY]}]
      remaining_shipment = subject.restock!(full_stock)
      subject.in_stock?(full_stock).should be_true
      remaining_shipment["steamed_milk"].should == 0 # because it was empty
      remaining_shipment["sugar"].should == 10 #because it was full
    end
  end

  describe 'NOM NOM-ing' do
    it 'consumes ingredients successfully if they are in stock' do
      subject.consume!("sugar" => 2, "cocoa" => 1).should == true
      subject.ingredients["sugar"].units.should == 8
      subject.ingredients["cocoa"].units.should == 9
    end

    it 'does not consume ingredients successfully if they are not in stock' do
      subject.consume!("sugar" => 11, "cocoa" => 1).should == false
      subject.ingredients["sugar"].units.should == 10
      subject.ingredients["cocoa"].units.should == 10
    end

    it 'does not consume ingredients even if they become suddenly not available' do
      subject.should_receive(:in_stock?).and_return(true)
      # Our transacton logic should kick in
      subject.consume!("sugar" => 11, "cocoa" => 1).should == false
      subject.ingredients["sugar"].units.should == 10
      subject.ingredients["cocoa"].units.should == 10

    end
  end

end
