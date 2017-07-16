require 'rails_helper'

RSpec.describe EventHost do
  it {should belong_to(:event)}
  it {should belong_to(:host)}  
end