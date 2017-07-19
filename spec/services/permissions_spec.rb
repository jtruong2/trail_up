require 'rails_helper'

RSpec.describe Permission do

  describe 'Permissions' do

    it 'Return user status' do
      user = nil
      expect(Permission.status(user)).to eq('guest')

      user = create(:user)
      expect(Permission.status(user)).to eq('user')

      user.role = 'admin'
      expect(Permission.status(user)).to eq('admin')
    end
  end
end