require 'rails_helper'

RSpec.describe Event, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:date)}
  it {should belong_to(:trail)}
  it {should have_many(:event_roles)}
  it {should have_many(:users).through(:event_roles)}
end
