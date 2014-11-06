# Form object for creating a Topic on the API.
class TopicForm
  constructor: (@$http, @settings) ->
  name: 'Untitled Topic'
  # user_id: @settings.userId
  questions: {}
  insertQuestion: (name) ->
    @questions[name] = []

  removeQuestion: (name) ->
    delete @questions[name]

  # TODO DRY up removePrompt and insertPrompt into a helper with cb.
  insertPrompt: (question, prompt) ->
    if not @questions[question]
      console.log "Could not find a question named #{prompt}"
    else
      @questions[question].push(prompt)

  removePrompt: (question, prompt) ->
    if not @questions[prompt]
      console.log "Could not find a question named #{prompt}"
    else
      @questions = (oldOne for oldOne in @questions when oldOne isnt prompt)

  save: ->
    console.log "do the AJAX"


angular.module('crustacean').factory('TopicForm', ['$http', 'Settings', ->(TopicForm)])