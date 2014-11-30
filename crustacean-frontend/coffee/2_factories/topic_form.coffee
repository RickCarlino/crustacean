# Form object for creating a Topic on the API.
class TopicForm
  constructor: (@$http, @settings) ->
    @user_id   = @settings.userId
    @name      = 'Untitled Topic'
    @questions = {}

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

  togglePrompt: (question, counterQuestion) ->
    if @questions[question].indexOf(counterQuestion) == -1
      @insertPrompt(question, counterQuestion)
    else
      @removePrompt(question, counterQuestion)


  save: =>
    good = (resp,status,headers) =>
      alert 'Your topic has been saved'
      window.location = "/"
    bad = (resp,status,headers) =>
      console.log(resp)
      console.log(status)
      console.log(headers)
      alert "Something went wrong. Try refreshing the page. Developers: see Javascript console for details"
    @$http.post("#{@settings.url}/topics", this).success(good).error(bad)

angular
.module('crustacean')
.factory "TopicForm", [
  '$http'
  'Settings'
  ($http, Settings) -> new TopicForm($http, Settings)
]
