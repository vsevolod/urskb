URSKBApp.config(["$httpProvider", "$stateProvider", "$urlRouterProvider", ($httpProvider, $stateProvider, $urlRouterProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  
  $urlRouterProvider
    .when(/clients/, '/clients')
    .otherwise("/")
  
  $stateProvider
    .state('/', {
      url: ''
      ncyBreadcrumb: {label: 'Главная'}
    })
    # Clients - Клиент. всё о клиенте
    .state('clients', {
      url: 'clients'
      views: {
        '': {templateUrl: 'clients/index.html', controller: 'ClientCtrl'}
        'form@': {templateUrl: 'clients/filter.html', controller: 'ClientFilterCtrl'}
      }
      ncyBreadcrumb: {label: 'Клиенты'}
    })
    .state('clients.show', {
      url: '/{clientId:[0-9]+}'
      views: {
        '': {templateUrl: 'clients/show.html', controller: 'ClientShowCtrl'}
        'form@': {templateUrl: 'clients/indicator_filter.html', controller: 'ClientIndicatorFilterCtrl'}
      }
      ncyBreadcrumb: {label: '{{client.name}}'}
    })
    # Dictionaries - Словари
    .state('dictionaries', {
      url: '/dictionaries'
      templateUrl: 'dictionaries/index.html'
      controller: 'DictionaryCtrl'
      ncyBreadcrumb: {parent: '/', label: 'Словари'}
    })
    .state('dictionaries.show', {
      url: '/{dictionaryId:[0-9]+}'
      templateUrl: 'dictionaries/index.html'
      controller: 'DictionaryCtrl'
      ncyBreadcrumb: {label: '{{dictionary.name}}'}
    })
    .state('dictionaries.show.edit', {
      url: '/edit'
      ncyBreadcrumb: {label: 'Редактирование'}
      views: {
        'form@': {templateUrl: 'dictionaries/edit.html', controller: 'DictionaryCtrl'}
      }
    })
    .state('dictionaries.new', {
      url: '/new'
      ncyBreadcrumb: {label: 'Добавление'}
      views: {
        'form@': {templateUrl: 'dictionaries/new.html', controller: 'DictionaryCtrl'}
      }
    })
    .state('dictionaries.show.new', {
      url: '/new'
      ncyBreadcrumb: {label: 'Добавление'}
      views: {
        'form@': {templateUrl: 'dictionaries/new.html', controller: 'DictionaryCtrl'}
      }
    })
    # Indicators - Индикаторы
    .state('indicators', {
      url: '/indicators'
      templateUrl: 'indicators/index.html'
      controller: 'IndicatorCtrl'
      ncyBreadcrumb: {parent: '/', label: 'Показатели'}
    })
    .state('indicators.show', {
      url: '/{indicatorId:[0-9]+}'
      templateUrl: 'indicators/show.html'
      controller: 'IndicatorCtrl'
      ncyBreadcrumb: {label: '{{indicator.name}}'}
    })
    .state('indicators.show.edit', {
      url: '/edit'
      ncyBreadcrumb: {label: 'Редактирование'}
      views: {
        'form@': {templateUrl: 'indicators/edit.html', controller: 'IndicatorCtrl'}
      }
    })
    .state('indicators.new', {
      url: '/new'
      ncyBreadcrumb: {label: 'Добавление'}
      views: {
        'form@': {templateUrl: 'indicators/new.html', controller: 'IndicatorCtrl'}
      }
    })
    .state('indicators.show.new', {
      url: '/new'
      ncyBreadcrumb: {label: 'Добавление'}
      views: {
        'form@': {templateUrl: 'indicators/new.html', controller: 'IndicatorCtrl'}
      }
    })

])
