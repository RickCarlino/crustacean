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
      params.params = {};
      params.params.user_id = this.settings.userId;
      return this.$http.post(this.topicPath(), params).success((function(_this) {
        return function(data) {
          return cb();
        };
      })(this)).error((function(_this) {
        return function(data) {
          return alert(data.error);
        };
      })(this));
    };

    TopicService.prototype.fetch = function() {
      return this.$http.get(this.topicPath(), {
        params: {
          user_id: this.settings.userId
        }
      }).success((function(_this) {
        return function(data) {
          return _this.all = data.topics;
        };
      })(this)).error((function(_this) {
        return function(data) {
          return alert(data.error);
        };
      })(this));
    };

    return TopicService;

  })();

  angular.module('crustacean').service('TopicService', ['$http', 'Settings', TopicService]);

}).call(this);

(function() {
  var TopicForm;

  TopicForm = (function() {
    function TopicForm($http, settings) {
      this.$http = $http;
      this.settings = settings;
      console.log("hi");
    }

    TopicForm.prototype.insertQuestion = function(name) {
      return this.questions[name] = [];
    };

    TopicForm.prototype.removeQuestion = function(name) {
      return delete this.questions[name];
    };

    TopicForm.prototype.insertPrompt = function(question, prompt) {
      if (!this.questions[question]) {
        return console.log("Could not find a question named " + prompt);
      } else {
        return this.questions[question].push(prompt);
      }
    };

    TopicForm.prototype.removePrompt = function(question, prompt) {
      var oldOne;
      if (!this.questions[prompt]) {
        return console.log("Could not find a question named " + prompt);
      } else {
        return this.questions = (function() {
          var _i, _len, _ref, _results;
          _ref = this.questions;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            oldOne = _ref[_i];
            if (oldOne !== prompt) {
              _results.push(oldOne);
            }
          }
          return _results;
        }).call(this);
      }
    };

    TopicForm.prototype.save = function() {
      return console.log("do the AJAX");
    };

    TopicForm.prototype.name = 'Untitled Topic';

    TopicForm.prototype.user_id = TopicForm.settings.userId;

    TopicForm.prototype.questions = {};

    return TopicForm;

  })();

  angular.module('crustacean').factory('TopicForm', [
    '$http', 'Settings', function() {
      return TopicForm;
    }
  ]);

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
  debugger;
  var NewTopicController;

  NewTopicController = (function() {
    function NewTopicController($scope, $http, topics, settings, TopicForm) {
      this.$scope = $scope;
      this.$http = $http;
      this.topics = topics;
      this.settings = settings;
      this.topic = new TopicForm;
    }

    NewTopicController.prototype.create = function() {
      return this.topic.save();
    };

    NewTopicController.prototype.setQuestion = function() {
      return this.topic.questions[prompt('Enter a name')] = ['one', 'two'];
    };

    NewTopicController.prototype.setTitle = function() {
      return this.topic.name = prompt('Enter New Name');
    };

    return NewTopicController;

  })();

  angular.module("crustacean").controller("newTopicController", ["$scope", "$http", "TopicService", "Settings", "TopicForm", NewTopicController]);

}).call(this);
