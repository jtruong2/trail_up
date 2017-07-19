require 'rails_helper'

RSpec.describe "As an admin" do
  it "can delete a user" do
    admin = create(:user, role: 'admin')
    user = create(:user)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    expect(User.count).to eq(2)
    visit admin_users_path
    within all('.user').last do
      click_link 'Delete'
    end
    expect(User.count).to eq(1)
  end
  it "deletes all user's hosted events when deleting a user" do
    admin = create(:user, role: "admin")
    user = create(:user)
    event = create(:event)
    user.event_roles.create(event_id: event.id, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_index_path
    within all('.admin-users').first do
      within all('.user').last do
        click_link 'Delete'
      end
    end
    
    expect(User.count).to eq(1)
    expect(EventRole.count).to eq(0)
    expect(Event.count).to eq(0)
  end
  it "cannot delete itself" do
    admin = create(:user, role: "admin")
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_index_path
    within all('.admin-users').first do
      within all('.user').first do
        click_link 'Delete'
      end
    end
    
    expect(User.count).to eq(2)
    expect(page).to have_content("You Cannot Delete Yourself!")
  end

end