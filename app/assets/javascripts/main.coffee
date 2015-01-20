URSKBApp.config(["$httpProvider", "$stateProvider", "$urlRouterProvider", ($httpProvider, $stateProvider, $urlRouterProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  
  $urlRouterProvider
    .otherwise("/")
  
  $stateProvider
    .state('/', {
      url: '/'
      ncyBreadcrumb: {label: 'Главная'}
    })
    .state('dictionaries', {
      url: '/dictionaries'
      templateUrl: 'dictionaries/index.html'
      controller: 'DictionaryCtrl'
      ncyBreadcrumb: {parent: '/', label: 'Словари'}
    })
    .state('dictionaries.show', {
      url: '/{dictionaryId:[0-9]+}'
      templateUrl: 'dictionaries/index.html'
      ncyBreadcrumb: {label: '{{dictionary.name}}'}
    })
    .state('dictionaries.show.edit', {
      url: '/edit'
      templateUrl: 'dictionaries/edit.html'
      ncyBreadcrumb: {label: 'Редактирование'}
    })

])
