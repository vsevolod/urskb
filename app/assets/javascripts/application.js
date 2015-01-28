//= require jquery
//= require underscore
//= require angular
//= require angular-ui-router
//= require angular-breadcrumb
//= require angular-rails-templates
//= require_tree ./templates
//= require angularjs/rails/resource
//= require_tree ./modules
//= require_self
//= require main
//= require_tree ./controllers

var URSKBApp = angular.module('URSKBApp', [
  'dictionary.services',
  'indicator.services',
  //= require angular-bootstrap
  //'ui.bootstrap',
  //'new.edit',
  'templates',
  'ui.router',
  'ncy-angular-breadcrumb'
]);
