# == Schema Information
#
# Table name: deck_statistics
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0), not null
#  correct_count   :integer          default(0), not null
#  incorrect_count :integer          default(0), not null
#  total_count     :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deck_id         :bigint           not null
#
# Indexes
#
#  index_deck_statistics_on_deck_id  (deck_id)
#
# Foreign Keys
#
#  fk_rails_...  (deck_id => decks.id)
#
class DeckStatistic < ApplicationRecord
  belongs_to :deck
end
