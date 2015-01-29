URSKBApp
  .controller 'ClientShowCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', ($state, $rootScope, $stateParams, $scope, Client) ->
    $scope.filter = []


    Client.get($stateParams.clientId).then (result) ->
      $scope.client = result
      console.log($scope.client)
  ]
