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
      $state.go('.edit', $stateParams)

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
      new_dictionary.parent_id = dictionary.id if dictionary
      new Dictionary(new_dictionary).create().then (result) ->
        $state.go("^")
      , (error_answer) ->
        _.each error_answer.data.errors, (v, k) ->
          $("#{selector}[name='#{k}']").addClass('has-error')

  ]
