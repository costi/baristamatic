require 'spec_helper'

describe BaristaMatic::RecipeIngredient do

  subject { described_class.new("coffee", 3)}
  let(:ingredients_costs){ {"coffee" => "0.50"} }

  before :each do
    described_class.stub(:ingredients_costs).and_return(ingredients_costs)
  end

  it 'has a cost' do
    expect(subject.cost).to eql("1.50".to_d)
  end

  it 'has a unit cost' do
    expect(subject.unit_cost).to eql("0.50".to_d)
  end


end
