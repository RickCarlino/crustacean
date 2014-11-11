class NewTopicController
  constructor: (@$scope, @$http, @topics, @Settings, TopicForm) ->
    console.log ':(' unless !!Settings
    @topic = TopicForm
  create: -> @topic.save()
  setQuestion: -> @topic.insertQuestion(prompt('Enter a name'))
  setTitle: -> @topic.name = prompt('Enter New Name')
  insertPrompt: (main_q) ->
    @topic.insertPrompt(main_q,
      prompt('Enter the exact name of the other question'))
angular
.module("crustacean")
.controller("newTopicController",
  ["$scope"
   "$http"
   "TopicService"
   "Settings"
   "TopicForm"
   NewTopicController])
