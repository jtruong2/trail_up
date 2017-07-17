require 'rails_helper'

RSpec.describe EventRole, type: :model do
  it {should validate_presence_of(:role)}
  it {should belong_to(:user)}
  it {should belong_to(:event)}
end
