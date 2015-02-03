URSKBApp
  .controller 'ClientIndicatorFilterCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicators = []
    $scope.filterIndicators = []

    Indicator.tree().then (result) ->
      $scope.indicators = result

    $scope.toggleFilter = (indicator) ->
      index = $scope.filterIndicators.indexOf(indicator)
      if index >= 0
        $scope.filterIndicators.splice(index, 1)
      else
        $scope.filterIndicators.push(indicator)

    $scope.calculateIndicators = () ->
      $rootScope.filterIndicators = $scope.filterIndicators
  ]
