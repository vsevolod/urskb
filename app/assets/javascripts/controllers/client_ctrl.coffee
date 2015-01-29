URSKBApp
  .controller 'ClientCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', 'Indicator', ($state, $rootScope, $stateParams, $scope, Client, Indicator) ->
    $scope.clients = []
    $scope.client = null #temprorary

    $rootScope.$watch 'clients', (event, toState, toParams) ->
      $scope.clients = $rootScope.clients

    Client.query({}).then (results) ->
      $rootScope.clients = results
      $scope.client = $rootScope.clients[0]
      Indicator.calculate(63, {on: '2014-11-22', clientId: $scope.client.id}).then (results) ->
        console.log(results)

  ]
