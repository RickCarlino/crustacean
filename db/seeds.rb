topic       = Topic.create(name: "Chickens of the World")

breed       = Question.create(name: "breed", topic: topic)
comb        = Question.create(name: "comb", topic: topic)
type        = Question.create(name: "type", topic: topic)
broodiness  = Question.create(name: "broodiness", topic: topic)

yokohama    = Fact.create(topic: topic)
  Answer.create(question: breed, data: 'Yokohama', fact: yokohama)
  Answer.create(question: comb, data: 'walnut', fact: yokohama)
  # You are not restricted to just one answer per question per fact
  Answer.create(question: type, data: 'light breed', fact: yokohama)
  Answer.create(question: type, data: 'softfeather', fact: yokohama)
  Answer.create(question: broodiness, data: 'rarely', fact: yokohama)


