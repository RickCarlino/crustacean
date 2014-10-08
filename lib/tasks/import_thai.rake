require 'csv'
namespace :import do
  desc "Manually test application with database of Thai words"
  task thai: :environment do
    puts ' = = = = = DESTROYING ALL RECORDS = = = ='
    Topic.destroy_all
    puts 'OK'
    topic   = Topic.create(name: 'Thai')
    user    = User.create
    english = Question.create(topic: topic, name: 'English',    special: false)
    thai    = Question.create(topic: topic, name: 'Thai',       special: true)
    classif = Question.create(topic: topic, name: 'Classifier', special: false)
    pt_spch = Question.create(topic: topic,
                              name: 'Part of Speech',
                              special: false)

    csv_text = File.read('data/thai.csv')
    csv = CSV.parse(csv_text, :headers => true)
    count = 0
    csv.each do |row|
      print '*'
      begin
        count += 1
        r    = row.to_hash.with_indifferent_access
        eng  = r[:English].split(/\;|\,/).map(&:squish)
        th   = r[:Thai]
        cls  = r[:Classifier].split(/\;|\,/).map(&:squish) if r[:Classifier]
        typ  = r[:Type].split(/\;|\,/).map(&:squish)
      rescue
        print count.to_s
        next
      end
      word = Fact.create(topic: topic)
      eng.map{|e| Answer.create(question: english, fact: word, data: e)}
                  Answer.create(question: thai, fact: word, data: th)
      cls.map{|c| Answer.create(question: classif, fact: word, data: c)} if cls
      typ.map{|t| Answer.create(question: pt_spch, fact: word, data: t)}
      print '-'
    end
  end
end