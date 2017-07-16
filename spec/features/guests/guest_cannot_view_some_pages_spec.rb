require 'rails_helper'

RSpec.describe 'Guest cannot view some pages' do

  it 'cannot view new trail path' do
    expect{ visit "/trails/new" }.to raise_error(ActionController::RoutingError)
  end

  it 'cannot view dashboard' do
    expect{ visit "/dashboard" }.to raise_error(ActionController::RoutingError)
  end
end