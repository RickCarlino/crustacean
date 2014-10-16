require 'csv'
namespace :import do
  desc "Manually test application with database of Thai words"
  task thai: :environment do
    puts ' = = = = = DESTROYING ALL TOPICS = = = ='
    Topic.destroy_all
    puts 'OK'
    topic   = Topic.create(name: 'Thai')

    english = Question.create(topic: topic, name: 'English')
    thai    = Question.create(topic: topic, name: 'Thai')
    classif = Question.create(topic: topic, name: 'Classifier')
    pt_spch = Question.create(topic: topic, name: 'Part of Speech')

    english.update_attributes(review_against: [thai])
    thai.update_attributes(review_against: [english, classif, pt_spch])
    classif.update_attributes(review_against: [thai])
    pt_spch.update_attributes(review_against: [])

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
    Review.random_review_for User.create, topic
  end
end