URSKBApp
  .controller 'ClientCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', ($state, $rootScope, $stateParams, $scope, Client) ->
    $scope.clients = []

    $rootScope.$watch 'clients', (event, toState, toParams) ->
      $scope.clients = $rootScope.clients

    Client.query({}).then (results) ->
      $rootScope.clients = results

  ]
