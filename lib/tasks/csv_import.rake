require 'csv'
namespace :import do
  desc "Manually test application with database of Thai words"
  task thai: :environment do
    # topic   = Topic.create(name: 'Thai')

    # english = Question.create(topic: topic, name: 'English',    special: true)
    # thai    = Question.create(topic: topic, name: 'Thai',       special: true)
    # classif = Question.create(topic: topic, name: 'Classifier', special: false)
    # pt_spch = Question.create(topic: topic,
    #                           name: 'Part of Speech',
    #                           special: false)

    csv_text = File.read('data/thai.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      r   = row.to_hash.with_indifferent_access
      eng = r[:English].split(/\;|\,/).map(&:squish)
      binding.pry
    end
  end
end