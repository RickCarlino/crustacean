(function() {
  angular.module('crustacean', []);

}).call(this);

(function() {
  var Settings;

  Settings = (function() {
    function Settings() {}

    Settings.prototype.userId = 1;

    Settings.prototype.url = 'http://crustacean.herokuapp.com';

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

    TopicService.prototype.fetch = function() {
      return this.$http.get(this.topicPath(), {
        params: {
          user_id: this.settings.userId
        }
      }).success((function(_this) {
        return function(data) {
          return console.log(_this.all = data.topics);
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

    TopicForm.prototype.togglePrompt = function(question, counterQuestion) {
      if (this.questions[question].indexOf(counterQuestion) === -1) {
        return this.insertPrompt(question, counterQuestion);
      } else {
        return this.removePrompt(question, counterQuestion);
      }
    };

    TopicForm.prototype.save = function() {
      var bad, good;
      good = (function(_this) {
        return function(resp, status, headers) {
          alert('Your topic has been saved');
          return window.location = "/";
        };
      })(this);
      bad = (function(_this) {
        return function(resp, status, headers) {
          console.log(resp);
          console.log(status);
          console.log(headers);
          return alert("Something went wrong. Try refreshing the page. Developers: see Javascript console for details");
        };
      })(this);
      return this.$http.post("" + this.settings.url + "/topics", this).success(good).error(bad);
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
      this.topic = TopicForm;
    }

    NewTopicController.prototype.step = 0;

    NewTopicController.prototype.up = function() {
      return this.step = this.step + 1;
    };

    NewTopicController.prototype.down = function() {
      if (this.step > 1) {
        return this.step = this.step - 1;
      }
    };

    NewTopicController.prototype.save = function() {
      return this.topic.save();
    };

    NewTopicController.prototype.hasQuestions = function() {
      return Object.keys(this.topic.questions).length > 0;
    };

    NewTopicController.prototype.insertPrompt = function(ques, prompt) {
      return this.topic.togglePrompt(ques, prompt);
    };

    NewTopicController.prototype.setQuestion = function() {
      this.topic.insertQuestion(this.newQuestion);
      return this.newQuestion = '';
    };

    return NewTopicController;

  })();

  angular.module("crustacean").controller("newTopicController", ["$scope", "$http", "TopicService", "Settings", "TopicForm", NewTopicController]);

}).call(this);
