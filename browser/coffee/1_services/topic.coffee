class TopicService
  constructor: (@$http, @settings) ->
    console.log ':(' unless !!settings
  all: []

  topicPath: (id) ->
    if !!id
      "#{@settings.url}/topics/#{id}"
    else
      "#{@settings.url}/topics"

  create: (params, cb) ->
    params.params = {}
    params.params.user_id = @settings.userId
    @$http
    .post(@topicPath(), params)
    .success((data) => cb())
    .error((data) => alert data.error)

  fetch: ->
    @$http
    .get(@topicPath(), {params: {user_id: @settings.userId}})
    .success((data) => @all = data.topics)
    .error((data) => alert data.error)

angular.module('crustacean').service 'TopicService', [
  '$http'
  'Settings'
  TopicService
]
