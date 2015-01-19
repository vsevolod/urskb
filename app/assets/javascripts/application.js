//= require angular
//= require angular-bootstrap
//= require angular-ui-router
//= require angular-rails-templates
//= require_tree ./templates
//= require angularjs/rails/resource
//= require modules/dictionary
//= require_self
//= require main
//= require controllers/dictionary_ctrl

var URSKBApp = angular.module('URSKBApp', [
      'dictionary.services',
      'templates',
      'ui.router'
    ]);
