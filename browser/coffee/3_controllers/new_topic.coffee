class NewTopicController
  constructor: (@$scope, @$http, @topics) ->
    @topic =
      name: null
      user_id: settings.user_id
      questions: {}
angular
.module("crustacean")
.controller("newTopicController",
  ["$scope", "$http", "TopicService", NewTopicController])
