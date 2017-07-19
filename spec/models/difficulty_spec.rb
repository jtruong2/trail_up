require 'rails_helper'

RSpec.describe Difficulty do

  describe 'Validations' do
    it { should have_one(:trail) }
  end
end