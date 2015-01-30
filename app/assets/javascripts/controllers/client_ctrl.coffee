URSKBApp
  .controller 'ClientCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', ($state, $rootScope, $stateParams, $scope, Client) ->
    $scope.clients = []
    $scope.client = null #temprorary

    $rootScope.$watch 'clients', (event, toState, toParams) ->
      $scope.clients = $rootScope.clients

    Client.query({}).then (results) ->
      $rootScope.clients = results
  ]
