(function() {
  angular.module('crustacean', []);

}).call(this);

(function() {
  var MainController;

  MainController = (function() {
    function MainController($scope, $http) {
      console.log($http);
    }

    MainController.prototype.world = 'Hello!!';

    return MainController;

  })();

  angular.module('crustacean').controller("mainController", ['$scope', '$http', MainController]);

}).call(this);
