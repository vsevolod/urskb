URSKBApp
  .controller 'ClientShowCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicators = {}

    Client.get($stateParams.clientId).then (result) ->
      $scope.client = result

    $scope.updateFilter = (v)->
      Indicator.calculate(v.id, {on: $rootScope.filterDate, clientId: $scope.client.id}).then (results) ->
        $scope.indicators[v.id] = {name: v.name, value: results}

    $rootScope.$watch('filterIndicators', (new_value, old_value) ->
      if new_value
        $.each(new_value, (index,v) ->
          if $scope.indicators[v.id] != 0 && ($scope.indicators[v.id] == undefined || $scope.indicators[v.id] != null)
            $scope.updateFilter(v)
        )
    , true)

    $rootScope.$watch('filterDate', (new_value, old_value) ->
      if new_value && new_value != old_value && ($rootScope.filterIndicators || []).length > 0
        $.each($rootScope.filterIndicators, (index,v) ->
          $scope.updateFilter(v)
        )
    )

  ]
