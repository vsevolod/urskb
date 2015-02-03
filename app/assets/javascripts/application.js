//= require jquery
//= require moment
//= require underscore
//= require angular
//= require angular-moment
//= require angular-ui-router
//= require angular-ui-tree/angular-ui-tree.js
//= require angular-breadcrumb
//= require angular-rails-templates
//= require angular-bootstrap-datetimepicker/datetimepicker.js
//= require moment/locale/ru.js
//= require_tree ./templates
//= require angularjs/rails/resource
//= require_tree ./modules
//= require_self
//= require main
//= require_tree ./controllers

moment.locale('ru');
var URSKBApp = angular.module('URSKBApp', [
      'ui.tree',
      'ui.bootstrap.datetimepicker',
      'dictionary.services',
      'indicator.services',
      'client.services',
      //= require angular-bootstrap
      //'ui.bootstrap',
      //'new.edit',
      'templates',
      'ui.router',
      'ncy-angular-breadcrumb'
    ]);
