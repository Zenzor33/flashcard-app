# lib/tasks/update_accuracy.rake
namespace :data_migration do
  desc "Update accuracy for FlashcardStatistic"
  task update_flashcard_statistics_accuracy: :environment do
    FlashcardStatistic.find_each do |statistic|
      correct = statistic.correct_count
      incorrect = statistic.incorrect_count
      total = correct + incorrect
      next if total.zero? # Skip if there are no attempts

      accuracy = (correct.to_f / total).round(2) # Or however you wish to calculate it
      statistic.update(accuracy: accuracy) # This will trigger callbacks and validations
    end
    puts "All FlashcardStatistic records have been updated with accuracy."
  end
end
