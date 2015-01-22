angular.module('new.edit'), [])
  .controller('NewEditController', ['$scope', ($scope) ->
    d
  ]
  .directive 'new-edit-ui', ->
    return {
      template: '<div ng-include="contentUrl"></div>'
      link: (scope, element, attrs) ->
        scope.contentUrl = "

    }
