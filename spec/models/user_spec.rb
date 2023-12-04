# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with an email and password" do 
    user = User.new(email: "user@example.com", password: "secret")
    expect(user).to be_valid
  end

  it "is invalid without an email" do 
    user = User.new(email: nil, password: "secret")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do 
    user = User.new(email: "user@example.com", password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do  
    User.create!(
      email: "dummy@example.com",
      password: "secret"
    )
    user = User.new(email: "dummy@example.com", password: "secret")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "it creates default deck for new users" do 
    user = User.create!(
      email: "dummy@example.com",
      password: "secret"
    )
    expect(user.deck).to be_present
  end 
end
