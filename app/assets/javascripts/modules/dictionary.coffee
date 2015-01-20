angular.module('dictionary.services', ['rails'])
  .factory 'Dictionary', ['railsResourceFactory', (railsResourceFactory) ->
    resource = railsResourceFactory({
      url: '/api/dictionaries'
      name: 'dictionary'
    })
    resource.children = (id) ->
      return this.$get("#{this.$url()}/#{id}/children")

    resource
  ]
