URSKBApp
  .controller 'DictionaryCtrl', ['$scope', 'Dictionary', ($scope, Dictionary) ->
    $scope.dictionaries = []

    Dictionary.query({}).then (results) ->
      $scope.dictionaries = results
  ]
