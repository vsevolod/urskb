URSKBApp
  .controller 'ClientShowCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicator = null

    Client.get($stateParams.clientId).then (result) ->
      $scope.client = result

    $scope.updateFilter = (v)->
      if $scope.client
        Indicator.calculate(v.uid, {on: $rootScope.filterDate, clientId: $scope.client.id}).then (results) ->
          $scope.indicator = {name: v.label, value: results}

    $rootScope.$watch('filterIndicator', (new_value, old_value) ->
      if new_value
        $scope.updateFilter(new_value)
    , true)

    $rootScope.$watch('filterDate', (new_value, old_value) ->
      if new_value && new_value != old_value && $rootScope.filterIndicator
        $scope.updateFilter($rootScope.filterIndicator)
    )

  ]
