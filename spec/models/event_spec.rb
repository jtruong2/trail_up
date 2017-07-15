require 'rails_helper'

RSpec.describe Event, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:date)}
  it {should belong_to(:trail)}
  it {should have_many(:event_guests)}
  it {should have_many(:guests).through(:event_guests).source(:guest)}
  it {should have_many(:event_hosts)}
  it {should have_many(:hosts).through(:event_hosts).source(:host)}
end
