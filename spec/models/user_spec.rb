require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_secure_password}
  it {should validate_presence_of(:username)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email)}
  it {should have_one(:picture)}
  it {should accept_nested_attributes_for(:picture)}
  it {should have_many(:event_guests)}
  it {should have_many(:attending).through(:event_guests).source(:event)}
  it {should have_many(:event_hosts)}
  it {should have_many(:hosting).through(:event_hosts).source(:event)}
  

end
