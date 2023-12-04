# == Schema Information
#
# Table name: dummies
#
#  id         :bigint           not null, primary key
#  age        :integer
#  born_at    :datetime
#  email      :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_dummies_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe Dummy, type: :model do
  it "must have an age greater than 21" do 
    dummy = create(:dummy) #Returns an actual instance of a dummy object
    dummy2 = create(:dummy)
    expect(dummy.email).to eq("hello+1@cjav.dev")
    expect(dummy2.email).to eq("hello+2@cjav.dev")
  end
end
