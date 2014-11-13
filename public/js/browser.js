(function() {
  angular.module('crustacean', []);

}).call(this);

(function() {
  var TopicForm,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  TopicForm = (function() {
    function TopicForm($http, settings) {
      this.$http = $http;
      this.settings = settings;
      this.save = __bind(this.save, this);
      this.user_id = this.settings.userId;
      this.name = 'Untitled Topic';
      this.questions = {};
    }

    TopicForm.prototype.insertQuestion = function(name) {
      return this.questions[name] = [];
    };

    TopicForm.prototype.removeQuestion = function(name) {
      return delete this.questions[name];
    };

    TopicForm.prototype.insertPrompt = function(question, prompt) {
      if (!!this.questions[prompt]) {
        return this.questions[question].push(prompt);
      } else {
        return console.log("Could not find a question named " + prompt);
      }
    };

    TopicForm.prototype.removePrompt = function(question, prompt) {
      var x;
      return this.questions[question] = (function() {
        var _i, _len, _ref, _results;
        _ref = this.questions;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          x = _ref[_i];
          if (x !== prompt) {
            _results.push(x);
          }
        }
        return _results;
      }).call(this);
    };

    TopicForm.prototype.save = function() {
      this.questions = {
        a: ['b'],
        b: ['a']
      };
      return this.$http.post("" + this.settings.url + "/topics", this).success((function(_this) {
        return function(resp, status, headers) {
          return console.log(resp.topic);
        };
      })(this)).error((function(_this) {
        return function(resp, status, headers) {
          return console.log(resp.topic);
        };
      })(this));
    };

    return TopicForm;

  })();

  angular.module('crustacean').factory("TopicForm", [
    '$http', 'Settings', function($http, Settings) {
      return new TopicForm($http, Settings);
    }
  ]);

}).call(this);

(function() {
  var Settings;

  Settings = (function() {
    function Settings() {}

    Settings.prototype.userId = 1;

    Settings.prototype.url = 'http://localhost:3000';

    return Settings;

  })();

  angular.module('crustacean').service('Settings', Settings);

}).call(this);

(function() {
  var TopicService;

  TopicService = (function() {
    function TopicService($http, settings) {
      this.$http = $http;
      this.settings = settings;
      if (!settings) {
        console.log(':(');
      }
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
    function NewTopicController($scope, $http, topics, Settings, TopicForm) {
      this.$scope = $scope;
      this.$http = $http;
      this.topics = topics;
      this.Settings = Settings;
      if (!Settings) {
        console.log(':(');
      }
      this.topic = TopicForm;
    }

    NewTopicController.prototype.create = function() {
      return this.topic.save();
    };

    NewTopicController.prototype.setQuestion = function() {
      return this.topic.insertQuestion(prompt('Enter a name'));
    };

    NewTopicController.prototype.setTitle = function() {
      return this.topic.name = prompt('Enter New Name');
    };

    NewTopicController.prototype.insertPrompt = function(main_q) {
      return this.topic.insertPrompt(main_q, prompt('Enter the exact name of the other question'));
    };

    return NewTopicController;

  })();

  angular.module("crustacean").controller("newTopicController", ["$scope", "$http", "TopicService", "Settings", "TopicForm", NewTopicController]);

}).call(this);
