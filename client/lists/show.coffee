Template.showList.rendered = ->
  $('body').css('background-color', Session.get('color'))
  Session.set('name', List.first(Session.get('listId')).name)

Template.showList.helpers
  list: ->
    List.first(Session.get('listId'))

  items: ->
    @related 'items', {sort: {score: -1}}

  canAdd: ->
    @canAddItem Meteor.user()

  couldAdd: ->
    !Meteor.user() && @open

Template.showList.events
  'submit .add-item, keyup form.add-item': (event) ->
    event.preventDefault()
    unless event.type is 'keyup' and event.ctrlKey and event.keyCode is 13
      return

    item = Item.create
      userId: Meteor.userId()
      itemUsername: Meteor.user().username
      listId: @id,
      text: $('#text').val()
      url: $('#url').val()
      createdAt: new Date()
      username: @username
      listSlug: @slug
      listName: @name

    if item.errors
      return alert 'Be more descriptive.'

    Meteor.call('touchList', @id, item.id)

    $('#text').val ''
    $('#text').focus()
    $('#url').val ''
