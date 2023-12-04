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
class Dummy < ApplicationRecord
end
