angular.module('indicator.services', ['rails'])
  .factory 'Indicator', ['RailsResource', (RailsResource) ->

    class Indicator extends RailsResource
      @configure
        url: '/api/indicators'
        name: 'indicator'

      children: (id) ->
        return this.$get("#{this.$url()}/#{id}/children")

      @indicator_rules: (id) ->
        return this.$get("#{this.$url()}/#{id}/indicator_rules")

      @calculate: (id, options) ->
        return this.$get("#{this.$url()}/#{id}/calculate", options)

      @tree: (type) ->
        return this.$get("#{this.$url()}/full_tree", type)

  ]
