require 'rails_helper'

RSpec.describe Picture do
  it {should belong_to(:imageable)}
end