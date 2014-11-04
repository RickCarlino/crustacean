class NewTopicController
  constructor: (@$scope, @$http, @topics, @settings) ->
    @topic =
      name: 'Untitled Topic'
      user_id: settings.userId
      questions: {}
  create: -> @topics.create(@topic)
  setQuestion: (name, against = []) ->
    @topic.questions[name] = against
  setTitle: -> @topic.name = prompt('Enter New Name')

angular
.module("crustacean")
.controller("newTopicController",
  ["$scope", "$http", "TopicService", "Settings", NewTopicController])
