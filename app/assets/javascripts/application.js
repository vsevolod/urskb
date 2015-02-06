//= require jquery
//= require moment
//= require underscore
//= require angular
//= require angular-i18n/angular-locale_ru-ru.js
//= require angular-bootstrap
//= require angular-moment
//= require angular-ui-router
//= require jsmodules/abn_tree_directive.js
//= require angular-breadcrumb
//= require angular-rails-templates
//= require moment/locale/ru.js
//= require_tree ./templates
//= require angularjs/rails/resource
//= require_tree ./modules
//= require_self
//= require main
//= require_tree ./controllers

moment.locale('ru');
var URSKBApp = angular.module('URSKBApp', [
      'angularBootstrapNavTree',
      'ui.bootstrap',
      'dictionary.services',
      'indicator.services',
      'client.services',
      //'new.edit',
      'templates',
      'ui.router',
      'ncy-angular-breadcrumb'
    ]);
