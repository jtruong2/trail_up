require 'rails_helper'

RSpec.describe User, type: :model do
  it "must have a password attribute" do
    user = User.create(username: "User Name", email: "example@gmail.com")
    expect(user).not_to be_valid
  end

  it "must have a username attribute" do
    user = User.create(email: "example@gmail.com", password: "password")
    expect(user).not_to be_valid
  end

  it "must have a email attribute" do
    user = User.create(username: "User Name", password: "password")
    expect(user).not_to be_valid
  end

  it "must have a unique username attribute" do
    valid_user = User.create(username: "User Name", email: "example@gmail.com", password: "password")
    invalid_user = User.create(username: "User Name", email: "example1@gmail.com", password: "password")
    expect(invalid_user).not_to be_valid
  end

  it "must have a unique email attribute" do
    valid_user = User.create(username: "User Name", email: "example@gmail.com", password: "password")
    invalid_user = User.create(username: "User Name1", email: "example@gmail.com", password: "password")
    expect(invalid_user).not_to be_valid
  end

end
