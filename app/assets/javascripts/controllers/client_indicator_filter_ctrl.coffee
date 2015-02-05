URSKBApp
  .controller 'ClientIndicatorFilterCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicatorsTree = []
    $scope.filterIndicators = []
    $scope.date = new Date

    Indicator.tree($scope.date).then (result) ->
      $scope.indicatorsTree = result

    $scope.toggleFilter = (indicator) ->
      index = $scope.filterIndicators.indexOf(indicator)
      if index >= 0
        $scope.filterIndicators.splice(index, 1)
      else
        $scope.filterIndicators.push(indicator)

    $scope.calculateIndicators = () ->
      $rootScope.filterIndicators = $scope.filterIndicators

    $scope.onTimeSet = (newDate, oldDate) ->
      if oldDate != newDate
        $rootScope.filterDate = newDate

  ]
