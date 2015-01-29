URSKBApp
  .controller 'ClientFilterCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', ($state, $rootScope, $stateParams, $scope, Client) ->
    $scope.client = {}

    $scope.filterClients = () ->
      Client.query(search: $scope.client).then (results) ->
        $rootScope.clients = results
  ]
