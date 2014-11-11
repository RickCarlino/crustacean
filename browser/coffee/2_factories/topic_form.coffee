# Form object for creating a Topic on the API.
class TopicForm
  constructor: (@$http, @settings) ->
  name: 'Untitled Topic'
  questions: {}
  insertQuestion: (name) ->
    @questions[name] = []

  removeQuestion: (name) ->
    delete @questions[name]

  # TODO DRY up removePrompt and insertPrompt into a helper with cb.
  insertPrompt: (question, prompt) ->
    if !!@questions[prompt]
      @questions[question].push(prompt)
    else
      console.log "Could not find a question named #{prompt}"

  removePrompt: (question, prompt) ->
    @questions[question] = (x for x in @questions when x isnt prompt)

  save: ->
    @user_id = @settings.userId
    good     = (resp,status,headers) -> debugger
    bad      = (resp,status,headers) -> debugger
    @$http.post("#{@settings.url}/topics", this).success(good).error(bad)

angular
.module('crustacean')
.factory "TopicForm", [
  '$http'
  'Settings'
  ($http, Settings) -> new TopicForm($http, Settings)
]
