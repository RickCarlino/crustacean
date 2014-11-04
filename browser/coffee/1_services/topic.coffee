class TopicService
  constructor: (@$http, @settings) ->
    console.log 'Topic'

  all: []

  topicPath: (id) ->
    if !!id
      "#{@settings.url}/topics/#{id}"
    else
      "#{@settings.url}/topics"

  create: (params) ->
    good = (data, status, headers, config) =>
      @fetch()
    bad  = (data, status, headers, config) =>
      alert data.error
    @$http
    .post(@topicPath(), params)
    .success(good)
    .error(bad)

  fetch: ->
    good = (data, status, headers, config) =>
      @all = data.topics
    bad  = (data, status, headers, config) =>
      alert data.error
    @$http
    .get(@topicPath(), {params: {user_id: @settings.userId}})
    .success(good)
    .error(bad)

angular.module('crustacean')
.service 'TopicService', ['$http', 'Settings', TopicService]
