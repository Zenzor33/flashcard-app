require 'csv'

namespace :flashcards do 
  desc "Import flashcards from CSV file"
  task import: :environment do 
    # arr_of_rows = CSV.read("ptwordlistcsv.csv")
    CSV.foreach("ptwordlistcsv.csv", headers: true) do |row|
      english = row['English']
      portuguese = row['Portuguese']
      puts english + ": " + portuguese
      Flashcard.create!(front: english, back: portuguese)
    end 
  end 
end 