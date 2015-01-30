URSKBApp
  .controller 'ClientShowCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.filter = []
    $scope.indicators = {}


    Client.get($stateParams.clientId).then (result) ->
      $scope.client = result

    Indicator.tree({with_sql: true).then (result) ->

      #Indicator.calculate(63, {on: '2015-01-20', clientId: $scope.client.id}).then (results) ->
      #  $scope.indicators[63] = results
  ]
