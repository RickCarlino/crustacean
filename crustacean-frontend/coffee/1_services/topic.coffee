class TopicService
  constructor: (@$http, @settings) ->
    console.log ':(' unless !!settings
  all: []

  topicPath: (id) ->
    if !!id
      "#{@settings.url}/topics/#{id}"
    else
      "#{@settings.url}/topics"

  fetch: ->
    @$http
    .get(@topicPath(), {params: {user_id: @settings.userId}})
    .success((data) => console.log(@all = data.topics))
    .error((data) => alert data.error)

angular.module('crustacean').service 'TopicService', [
  '$http'
  'Settings'
  TopicService
]
