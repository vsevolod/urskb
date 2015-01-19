URSKBApp.config(["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
  #$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  
  #$urlRouterProvider.otherwise("/")
  
  $stateProvider
    .state('/dictionaries', {
      url: '/dictionaries',
      templateUrl: 'dictionaries/index.html'
    })

])
