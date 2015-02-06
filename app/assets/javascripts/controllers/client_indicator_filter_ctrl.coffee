URSKBApp
  .controller 'ClientIndicatorFilterCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicatorsTree = []
    $scope.date = new Date

    Indicator.tree($scope.date).then (result) ->
      $scope.indicatorsTree = result

    $scope.toggleFilter = (indicator) ->
      $rootScope.filterIndicator = indicator

    $scope.onTimeSet = (newDate, oldDate) ->
      if oldDate != newDate
        $rootScope.filterDate = newDate

  ]
