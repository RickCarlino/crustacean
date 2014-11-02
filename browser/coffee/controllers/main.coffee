class MainController
  constructor: ($scope, $http) ->
    console.log $http
  world: 'Hello!!'

angular
.module('crustacean')
.controller("mainController", ['$scope', '$http', MainController])