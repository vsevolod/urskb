URSKBApp
  .controller 'TopMenuCtrl', ['$scope', '$location', ($scope, $location) ->

    $scope.menu = [
      {name: 'Главная', url: '/', active: /^\/$/}
      {name: 'Словари', url: 'dictionaries', active: /\/dictionaries/}
      {name: 'Показатели', url: 'indicators', active: /\/indicators/}
    ]

    $scope.getClass = (expected_location) ->
      if expected_location.test($location.path())
        'active'
  ]
