angular.module('client.services', ['rails'])
  .factory 'Client', ['RailsResource', (RailsResource) ->
    class Client extends RailsResource
      @configure
        url: '/api/clients'
        name: 'client'
  ]
