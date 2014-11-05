class NewTopicController
  constructor: (@$scope, @$http, @topics, @settings) ->
    @topic =
      name: 'Untitled Topic'
      user_id: settings.userId
      questions: {}

  create: ->
    @topics.create(@topic)
  setQuestion: () ->
    console.log ':('
    name = prompt('Enter a name')
    # @topic.questions[name] = []
  setTitle: -> @topic.name = prompt('Enter New Name')

angular
.module("crustacean")
.controller("newTopicController",
  ["$scope", "$http", "TopicService", "Settings", NewTopicController])
