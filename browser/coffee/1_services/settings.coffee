class Settings
  constructor: ->
    console.log 'ApiSettings'
  userId: 1
  url: 'http://localhost:3000'

angular.module('crustacean').service 'Settings', [Settings]
