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

  describe 'validations' do 
    let(:user) { FactoryBot.build(:user)}
    
    it "is valid with an email and password" do 
      expect(user).to be_valid
    end

    it "is invalid without an email" do 
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do 
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do 
      existing_user = FactoryBot.create(:user)
      user.email = existing_user.email
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe 'associations' do 
    it "it creates default deck for new users" do 
      user = FactoryBot.create(:user)
      expect(user.deck).to be_present
    end 
  end
end
