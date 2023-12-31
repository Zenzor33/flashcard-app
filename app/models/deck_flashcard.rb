# == Schema Information
#
# Table name: deck_flashcards
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0), not null
#  attempts        :integer          default(0), not null
#  category        :string           default("new"), not null
#  correct_count   :integer          default(0), not null
#  incorrect_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deck_id         :bigint           not null
#  flashcard_id    :bigint           not null
#
# Indexes
#
#  index_deck_flashcards_on_deck_id                   (deck_id)
#  index_deck_flashcards_on_deck_id_and_flashcard_id  (deck_id,flashcard_id) UNIQUE
#  index_deck_flashcards_on_flashcard_id              (flashcard_id)
#
# Foreign Keys
#
#  fk_rails_...  (deck_id => decks.id)
#  fk_rails_...  (flashcard_id => flashcards.id)
#
class DeckFlashcard < ApplicationRecord
  belongs_to :deck
  belongs_to :flashcard

  validates :correct_count, :incorrect_count, :attempts, 
    presence: true, 
    numericality: { 
      only_integer: true, 
      greater_than_or_equal_to: 0 
  }
  validates :accuracy, 
  presence: true, 
  numericality: {
    only_float: true, 
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
  validates :category, presence: true

  before_save :update_deck_flashcard_statistics
  after_save :update_deck_statistics
  after_destroy :update_deck_statistics
  after_create_commit { broadcast_deck_flashcards }
  after_destroy_commit { broadcast_deck_flashcards }

  scope :by_category, -> (category) {category.nil? ? all : where(category: category)}

  def self.flashcard 
    # Change to self.get_flashcard ?
    Flashcard.find_by(self.flashcard_id)
  end 

  # Used for scoped collections eg @categorized_deck_flashcards
  def self.average_accuracy
    total_attempts = self.total_correct_count + self.total_incorrect_count
    return 0.0 if total_attempts.zero? 
    
    accuracy = self.total_correct_count.to_f / total_attempts
    accuracy
  end 

  def self.total_correct_count
    self.sum(:correct_count)
  end

  def self.total_incorrect_count
    self.sum(:incorrect_count)
  end

  private

  def broadcast_deck_flashcards
    @deck = self.deck
    # Initiate a broadcast to a Turbo Stream identified by the name "deck_flashcards"
    broadcast_update_to [@deck, "deck_flashcards"],
    # Specifies the partial view that will be rendered and sent as part of the broadcast.
    partial: "layouts/counter",
    #  local variables to the partial.
    # the collection of deck flashcards (deck.deck_flashcards) associated with the deck of the current 
    locals: { deck: @deck},
    #  specifies the DOM element i
    target: "deck-cards-counter"
  end 

  def update_deck_statistics
    deck = Deck.find_by(id: self.deck_id)
    deck.update_statistics
  end 

  def update_deck_flashcard_statistics
    update_attempts
    update_accuracy
    update_category
  end 

  def update_accuracy
    self.accuracy = attempts.zero? ? 0.0 : (correct_count.to_f / attempts * 100)
  end

  def update_attempts
    self.attempts = correct_count.to_i + incorrect_count.to_i
  end 

  def update_category
    case 
    when attempts > 5 && accuracy >= 90
      self.category = "mastered"
    when attempts > 5 && accuracy > 65
      self.category = "progressing" 
    when attempts > 0 && attempts <= 5 || attempts > 5 && accuracy <= 65
      self.category = "learning"
    when attempts == 0
      self.category = "new" 
    else  
      puts "This should not happen in update_category"
    end
  end
end
