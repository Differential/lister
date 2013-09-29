Template.showList.rendered = ->
  $('body').css('background-color', Session.get('color'))
  Session.set('name', List.first(Session.get('listId')).name)

Template.showList.helpers
  list: ->
    List.first(Session.get('listId'))

  items: ->
    list = List.first(Session.get('listId'))
    list.related('items', {sort: {score: -1}}) if list

  canAdd: ->
    list = List.first(Session.get('listId'))
    list.canAddItem Meteor.user()

  couldAdd: ->
    list = List.first(Session.get('listId'))
    !Meteor.user() && list && list.open

Template.showList.events
  'submit .add-item': (event) ->
    event.preventDefault()

    item = Item.create
      userId: Meteor.userId()
      itemUsername: Meteor.user().username
      listId: Session.get('listId'),
      text: $('#text').val()
      url: $('#url').val()
      createdAt: new Date()
      username: List.first(Session.get('listId')).username
      listSlug: List.first(Session.get('listId')).slug
      listName: List.first(Session.get('listId')).name

    if item.errors
      return alert 'Be more descriptive.'

    Meteor.call('touchList', Session.get('listId'), item.id)

    $('#text').val ''
    $('#text').focus()
    $('#url').val ''
