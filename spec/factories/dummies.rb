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
FactoryBot.define do
  factory :dummy do
    name { "MyString" }
    age { rand(1..100) }
    born_at { "2023-12-02 11:08:36" }
    sequence(:email)  { |n| "hello+#{n}@cjav.dev" }
  end
end
