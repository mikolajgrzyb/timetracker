window.App = {}

App.MemberApp =

  activeMembers: $('.active-members')
  inactiveMembers: $('.inactive-members')

  start: ->
    $("[data-js=state-button]").click $.proxy(@_onTogglActiveClick, @)

  _onTogglActiveClick: (event) ->
    event.preventDefault()
    $currentTarget = $(event.currentTarget)
    id = $currentTarget.data('id')
    action = $currentTarget.data('action')

    state = action is 'activate' ? true: false
    @_updateUser(id, state, $currentTarget)


  _updateUser: (id, state, $currentTarget) ->
    $.ajax
      url: window.location.href + '/' + id
      method: 'PUT'
      data:
        active: state
      success: $.proxy @_onUpdateSuccess, @, $currentTarget, state


  _onUpdateSuccess: ($currentTarget, state)->
    currentAction = if state
      'deactivate'
    else
      'activate'

    $currentTarget.data('action', currentAction)
    $currentTarget.text(currentAction)
    $tr = $currentTarget.closest('tr')

    tableName = if state then 'activeMembers' else 'inactiveMembers'
    previousTable = if state then 'inactiveMembers'  else 'activeMembers'

    @[tableName].find('tbody').append($tr)

    if @[previousTable].find('.user').length > 0
      @[previousTable].find('.empty').addClass('hide')
    else
      @[previousTable].find('.empty').removeClass('hide')


    if @[tableName].find('.user').length > 0
      @[tableName].find('.empty').addClass('hide')
    else
      @[tableName].find('.empty').removeClass('hide')
























