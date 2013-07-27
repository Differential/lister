Template.showList.helpers
  list: ->
    Lists.findOne(Session.get('listId'))

  items: ->
    Items.find(listId: Session.get('listId'))

  itemsReady: ->
    Session.get('itemsReady')

  isOwner: ->
    list = Lists.findOne(Session.get('listId'))
    list && list.userId == Meteor.userId()

Template.showList.events
  'submit .add-item': ->
      event.preventDefault()
      Items.insert(
        userId: Meteor.userId()
        listId: Session.get('listId'),
        text: $('#text').val()
        url: $('#url').val()
        createdAt: new Date()
        username: Meteor.user().username
        listSlug: Lists.findOne(Session.get('listId')).slug
        listName: Lists.findOne(Session.get('listId')).name
      )
      $('#text').val ''
      $('#url').val ''
