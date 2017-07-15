require 'rails_helper'

RSpec.describe EventGuest do
  it {should belong_to(:event)}
  it {should belong_to(:guest)}  
end