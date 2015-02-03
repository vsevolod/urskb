URSKBApp
  .controller 'IndicatorCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Indicator', ($state, $rootScope, $stateParams, $scope, Indicator) ->
    $scope.indicator = null
    $scope.indicator_rules = []
    $scope.new_indicator = null
    $scope.indicators = []
    $scope.breadcrumbs = []

    $scope.updateVariables = (option) ->
      if option.indicatorId
        Indicator.get(option.indicatorId).then (result) ->
          $scope.indicator = result
          Indicator.indicator_rules($scope.indicator.id).then (results) ->
            $scope.indicators = []
            $scope.indicator_rules = results
      else
        $scope.indicator = null
        $scope.indicator_rules = []
        Indicator.query({}).then (results) ->
          $scope.indicators = results

    $scope.updateVariables($stateParams)
    $rootScope.$on '$stateChangeStart', (event, toState, toParams) ->
      if ($scope.indicator || {}).id != toParams.indicatorId
        $scope.updateVariables(toParams)

    $scope.edit = ->
      $state.go('indicators.show.edit', $stateParams)

    $scope.new = ->
      url = if $scope.indicator then 'indicators.show.new' else 'indicators.new'
      $state.go(url, $stateParams)

    $scope.destroy = ->
      $scope.indicator.delete().then (result) ->
        if $scope.indicator.parent_id
          $state.go("indicators.show({indicatorId:#{$scope.indicator.parent_id}})")
        else
          $scope.indicator = null
          $state.go("indicators")

    $scope.save = ->
      selector = 'form.indicator_form .form-group'
      $(selector).removeClass('has-error')
      $scope.indicator.update().then (result) ->
        $state.go("^")
      , (error_answer) ->
        _.each error_answer.data.errors, (v, k) ->
          $("#{selector}[name='#{k}']").addClass('has-error')

    $scope.create = ->
      selector = 'form.new_indicator_form .form-group'
      $(selector).removeClass('has-error')
      $scope.new_indicator.parent_id = $scope.indicator.id if $scope.indicator
      new Indicator($scope.new_indicator).create().then (result) ->
        $state.go("^")
      , (error_answer) ->
        _.each error_answer.data.errors, (v, k) ->
          $("#{selector}[name='#{k}']").addClass('has-error')

    # Получение массива по правилам для индикатора (i).
    # Option - хэш:
    # rule: children_rules или parent_rules
    # attribute: аттрибут для правила. Если пустой - возвращаем всё правило.
    $scope.getRules = (i, option) ->
      _.map(i[option.rule], (rule) ->
        if option.attribute
          rule[option.attribute]
        else
          rule
      )
  ]
