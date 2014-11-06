class NewTopicController
  constructor: (@$scope, @$http, @topics, @Settings, TopicForm) ->
    @topic = new TopicForm
  create: -> @topic.save()
  setQuestion: -> @topic.questions[prompt('Enter a name')] = ['one', 'two']
  setTitle: -> @topic.name = prompt('Enter New Name')

angular
.module("crustacean")
.controller("newTopicController",
  ["$scope"
   "$http"
   "TopicService"
   "Settings"
   "TopicForm"
   NewTopicController])
