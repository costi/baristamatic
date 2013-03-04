require 'spec_helper'

describe BaristaMatic::Drink do

  subject { described_class.new("irish_coffee")}
  let(:recipes){ {"irish_coffee" => {"whiskey" => 1, "coffee" => 3}} }

  before :each do
    described_class.stub(:recipes).and_return(recipes)
  end

  it 'has a cost' do
    coffee = double(:cost => "1.5".to_d)
    whiskey = double(:cost => "3.3".to_d)

    subject.should_receive(:ingredient).with("whiskey", 1).and_return(whiskey)
    subject.should_receive(:ingredient).with("coffee", 3).and_return(coffee)
    subject.cost.should == "4.8".to_d
  end

  it 'can tell if it is in stock' do
    subject.stub(:ingredients_storage).and_return(double("Test Storage"))
    subject.ingredients_storage.should_receive(:in_stock?).with({"whiskey" => 1, "coffee" => 3}).and_return(true)
    subject.in_stock?.should be_true
  end


end
