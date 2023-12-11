# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
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

    it { should validate_presence_of(:email) }
    
    # it "is invalid without a password" do 
    #   user.password = nil
    #   user.valid?
    #   expect(user.errors[:password]).to include("can't be blank")
    # end

    it { should validate_presence_of(:password) }


    # it "is invalid with a duplicate email address" do 
    #   existing_user = FactoryBot.create(:user)
    #   user.email = existing_user.email
    #   expect(user).to_not be_valid
    #   expect(user.errors[:email]).to include("has already been taken")
    # end

    it { should validate_uniqueness_of(:email).case_insensitive }

  end

  describe 'callbacks' do 
    it "it creates default deck for new users" do 
      user = FactoryBot.create(:user)
      expect(user.deck).to be_present
    end 
  end
end
