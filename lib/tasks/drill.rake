# require 'simplecov'
# SimpleCov.start do
#   add_filter "/test/"
#   add_filter "lib/tasks/"
# end

class Drill
  attr_accessor :user, :topic, :reviews

  def self.run!
    self.new
  end

  def initialize
    set_user
    set_topic
    @reviews = Review.due(@user)
    review_or_learn
  end

  def set_user
    User.create if User.count < 1
    puts "Enter User ID #{User.pluck(:id).first(5)}:"
    @user = User.find(input)
  end

  def set_topic
    puts "Enter Topic ID:"
    Topic.all.each{|t| puts "#{t.id}: #{t.name}"}
    @topic = Topic.find(input)
  end

  def reviews
    @reviews = Review.due(@user)
  end

  def review_or_learn
    if @reviews.empty?
      puts 'No reviews due. Lets learn new material instead.'
      learn
    else
      review_all
    end
  end

  def learn
    bad  = Review.where(owner: @user).pluck(:fact_id)
    fact = Fact.where.not(id: bad).order('random()').first
    fact.create_review_for(@user)
    review_all
  end

  def review_all
    @reviews.each{ |r| review(r) }
  end

  def review(review)
    binding.pry
    puts '='*review.prompt.length
    puts review.prompt
    puts '='*review.prompt.length
    review.choices.each_with_index do |choice, index|
      puts "#{index + 1}: #{choice}"
    end
    exit if input == 'q'
    review_or_learn
  end

  def input
    STDOUT.flush
    STDIN.gets.chomp
  end

  def puts(msg)
    STDOUT.puts msg
  end
end

task drill: :environment do
  Drill.run!
end
