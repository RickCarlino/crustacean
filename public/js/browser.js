(function() {
  angular.module('crustacean', []);

}).call(this);

(function() {
  var Settings;

  Settings = (function() {
    function Settings() {
      console.log('ApiSettings');
    }

    Settings.prototype.userId = 1;

    Settings.prototype.url = 'http://localhost:3000';

    return Settings;

  })();

  angular.module('crustacean').service('Settings', [Settings]);

}).call(this);

(function() {
  var TopicService;

  TopicService = (function() {
    function TopicService($http, settings) {
      this.$http = $http;
      this.settings = settings;
      console.log('Topic');
    }

    TopicService.prototype.all = [];

    TopicService.prototype.topicPath = function(id) {
      if (!!id) {
        return "" + this.settings.url + "/topics/" + id;
      } else {
        return "" + this.settings.url + "/topics";
      }
    };

    TopicService.prototype.create = function(params, cb) {
      var bad, good;
      good = (function(_this) {
        return function(data, status, headers, config) {
          return cb();
        };
      })(this);
      bad = (function(_this) {
        return function(data, status, headers, config) {
          return alert(data.error);
        };
      })(this);
      return this.$http.post(this.topicPath(), params).success(good).error(bad);
    };

    TopicService.prototype.fetch = function() {
      var bad, good;
      good = (function(_this) {
        return function(data, status, headers, config) {
          return _this.all = data.topics;
        };
      })(this);
      bad = (function(_this) {
        return function(data, status, headers, config) {
          return alert(data.error);
        };
      })(this);
      return this.$http.get(this.topicPath(), {
        params: {
          user_id: this.settings.userId
        }
      }).success(good).error(bad);
    };

    return TopicService;

  })();

  angular.module('crustacean').service('TopicService', ['$http', 'Settings', TopicService]);

}).call(this);

(function() {
  var MainController;

  MainController = (function() {
    function MainController($scope, $http, topics) {
      this.$scope = $scope;
      this.$http = $http;
      this.topics = topics;
    }

    MainController.prototype.getTopics = function() {
      return this.topics.fetch();
    };

    MainController.prototype.createTopic = function() {
      return this.topics.create();
    };

    return MainController;

  })();

  angular.module('crustacean').controller("mainController", ['$scope', '$http', 'TopicService', MainController]);

}).call(this);

(function() {
  var NewTopicController;

  NewTopicController = (function() {
    function NewTopicController($scope, $http, topics, settings) {
      this.$scope = $scope;
      this.$http = $http;
      this.topics = topics;
      this.settings = settings;
      this.topic = {
        name: 'Untitled Topic',
        user_id: settings.userId,
        questions: {}
      };
    }

    NewTopicController.prototype.create = function() {
      return this.topics.create(this.topic);
    };

    NewTopicController.prototype.setQuestion = function(name, against) {
      if (against == null) {
        against = [];
      }
      return this.topic.questions[name] = against;
    };

    NewTopicController.prototype.setTitle = function() {
      return this.topic.name = prompt('Enter New Name');
    };

    return NewTopicController;

  })();

  angular.module("crustacean").controller("newTopicController", ["$scope", "$http", "TopicService", "Settings", NewTopicController]);

}).call(this);
