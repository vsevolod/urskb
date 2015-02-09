URSKBApp
  .controller 'ClientIndicatorFilterCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicatorsTree = []
    $scope.date = new Date()
    $scope.$watch('date', (newDate, oldDate) ->
      if oldDate != newDate
        $rootScope.filterDate = newDate
    )

    Indicator.tree($scope.date).then (result) ->
      $scope.indicatorsTree = result

    $scope.toggleFilter = (indicator) ->
      $rootScope.filterIndicator = indicator

    $scope.dateOptions = {
      formatYear: 'yy',
      startingDay: 1
    }

    $scope.open = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true
  ]
