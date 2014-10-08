class Drill
  attr_accessor :user, :topic, :reviews

  def self.run!
    self.new
  end

  def initialize
    set_user
    set_topic
    set_reviews
    review_or_learn
  end

  def set_user
    puts "Enter User ID #{User.pluck(:id).first(5)}:"
    @user = User.find(input)
  end

  def set_topic
    puts puts "Enter Topic ID:"
    Topic.all.each{|t| puts "#{t.id}: #{t.name}"}
    @topic   = Topic.find(input)
  end

  def set_reviews
    @reviews = Review.due(@user)
  end

  def review_or_learn
    if @reviews.empty?
      puts 'No reviews due. Lets learn new material instead.'
      learn
    else
      review
    end
  end

  def learn
    Review.create_for user, topic: topic
    review
  end

  def review
    @reviews = Review.due(user)
    a = @reviews.map do |r|
      {owner:    r.owner.id,
       answers:  r.question.answers.where(fact: r.fact).pluck(:data),
       question: r.answer.data}
    end
    binding.pry
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
