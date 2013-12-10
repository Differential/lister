Template.newList.rendered = ->

  $('body').css('background-color', Session.get('color'))

Template.newList.events

  'change .max-votes [type=checkbox]': (e) ->

    if $(e.currentTarget).prop 'checked'
      $('[name=maxvotes]').prop 'disabled', false
    else
      $('[name=maxvotes]').val('').prop 'disabled', true

  'click .for-show-options': (e) ->
    e.preventDefault()

    $('.options').fadeToggle (e) ->
      # Reset all the options
      if not $(@).is ':visible'
        $('[type=checkbox]').prop 'checked', false
        $('[name=maxvotes]').val('').prop 'disabled', true

  'submit .newList': (e) ->
    e.preventDefault()

    name = $('[name=name]')
    open = $('[name=open]')
    hidden = $('[name=hidden]')
    downvotes = $('[name=downvotes]')
    limit = $('[name=limit]')
    maxvotes = $('[name=maxvotes]')

    list = List.create
      userId: Meteor.userId()
      username: Meteor.user().username
      name: name.val()
      open: open.is(':checked')
      hidden: hidden.is(':checked')
      downvotes: downvotes.is(':checked')
      limit: limit.is(':checked')
      maxvotes: maxvotes.val()
      createdAt: new Date()
      updatedAt: new Date()

    if list.errors
      return alert(_(list.errors[0]).values()[0])

    name.val ''
    Router.go('/lists')
