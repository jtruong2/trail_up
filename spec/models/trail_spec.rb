require 'rails_helper'

RSpec.describe Trail, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:difficulty)}
  it {should validate_presence_of(:distance)}
  it {should validate_presence_of(:rating)}
  it {should have_many(:events)}
end
