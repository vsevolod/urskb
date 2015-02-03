URSKBApp
  .controller 'ClientShowCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.indicators = {}

    Client.get($stateParams.clientId).then (result) ->
      $scope.client = result

    $rootScope.$watch('filterIndicators', (new_value, old_value) ->
      if new_value
        $.each(new_value, (index,v) ->
          if $scope.indicators[v.id] != 0 && ($scope.indicators[v.id] == undefined || $scope.indicators[v.id] != null)
            Indicator.calculate(v.id, {on: '2015-01-20', clientId: $scope.client.id}).then (results) ->
              $scope.indicators[v.id] = {name: v.name, value: results}
        )
    , true)
  ]
