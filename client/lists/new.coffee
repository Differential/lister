Template.newList.rendered = ->
  $('body').css('background-color', Session.get('color'))
  document.title = "Add list ~ lister.io"

Template.newList.events
  'submit .newList': (event) ->
    event.preventDefault()
    name = $('[name=name]')
    open = $('[name=open]')

    List.create
      userId: Meteor.userId()
      username: Meteor.user().username
      name: name.val()
      open: open.is(':checked')
      createdAt: new Date()
      updatedAt: new Date()

    name.val ''
    Router.go('/lists')
