class NewTopicController
  constructor: (@$scope, @$http, @topics, @Settings, TopicForm) ->
    @topic = TopicForm
  step: 0
  up: -> @step = @step + 1
  down: -> @step = @step - 1 if @step > 1
  save: -> @topic.save()
  hasQuestions: -> Object.keys(@topic.questions).length > 0
  insertPrompt: (ques, prompt) -> @topic.togglePrompt(ques, prompt)
  setQuestion: ->
    @topic.insertQuestion(@newQuestion)
    @newQuestion = ''

angular
.module("crustacean")
.controller("newTopicController",
  ["$scope"
   "$http"
   "TopicService"
   "Settings"
   "TopicForm"
   NewTopicController])
