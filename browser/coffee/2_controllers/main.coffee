class MainController
  constructor: (@$scope, @$http, @topics) ->
  getTopics: -> @topics.fetch()
  createTopic: -> @topics.create()


angular
.module('crustacean')
.controller("mainController", ['$scope', '$http', 'TopicService', MainController])
