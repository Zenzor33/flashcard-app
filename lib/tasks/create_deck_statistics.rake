# lib/tasks/create_deck_statistics.rake
namespace :deck_statistics do
  desc "Create a DeckStatistic for each Deck"
  task create: :environment do
    Deck.find_each do |deck|
      # Assuming DeckStatistic is initialized with default values
      # or you can set specific values as needed
      DeckStatistic.create(deck_id: deck.id)
    end

    puts "Deck statistics created for all decks."
  end
end
