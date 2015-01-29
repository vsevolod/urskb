URSKBApp
  .controller 'ClientIndicatorFilterCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Client', ($state, $rootScope, $stateParams, $scope, Client) ->
    $scope.indicators = []
  ]
