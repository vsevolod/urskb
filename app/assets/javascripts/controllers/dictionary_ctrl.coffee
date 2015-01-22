URSKBApp
  .controller 'DictionaryCtrl', ['$state', '$rootScope', '$stateParams', '$scope', 'Dictionary', ($state, $rootScope, $stateParams, $scope, Dictionary) ->
    $scope.dictionary = null
    $scope.new_dictionary = null
    $scope.dictionaries = []
    $scope.breadcrumbs = []

    $scope.updateVariables = (option) ->
      if option.dictionaryId
        Dictionary.get(option.dictionaryId).then (result) ->
          $scope.dictionary = result
          Dictionary.children($scope.dictionary.id).then (results) ->
            $scope.dictionaries = results
      else
        $scope.dictionary = null
        Dictionary.query({}).then (results) ->
          $scope.dictionaries = results

    $scope.updateVariables($stateParams)
    $rootScope.$on '$stateChangeStart', (event, toState, toParams) ->
      if ($scope.dictionary || {}).id != toParams.dictionaryId
        $scope.updateVariables(toParams)

    $scope.edit = ->
      $state.go('dictionaries.show.edit', $stateParams)

    $scope.new = ->
      url = if $scope.dictionary then 'dictionaries.show.new' else 'dictionaries.new'
      console.log(url)
      $state.go(url, $stateParams)

    $scope.destroy = ->
      $scope.dictionary.delete().then (result) ->
        if $scope.dictionary.parent_id
          $state.go("dictionaries.show({dictionaryId:#{$scope.dictionary.parent_id}})")
        else
          $scope.dictionary = null
          $state.go("dictionaries")

    $scope.save = ->
      selector = 'form.dictionary_form .form-group'
      $(selector).removeClass('has-error')
      $scope.dictionary.update().then (result) ->
        $state.go("^")
      , (error_answer) ->
        _.each error_answer.data.errors, (v, k) ->
          $("#{selector}[name='#{k}']").addClass('has-error')

    $scope.create = ->
      selector = 'form.new_dictionary_form .form-group'
      $(selector).removeClass('has-error')
      $scope.new_dictionary.parent_id = $scope.dictionary.id if $scope.dictionary
      new Dictionary($scope.new_dictionary).create().then (result) ->
        $state.go("^")
      , (error_answer) ->
        _.each error_answer.data.errors, (v, k) ->
          $("#{selector}[name='#{k}']").addClass('has-error')

  ]
