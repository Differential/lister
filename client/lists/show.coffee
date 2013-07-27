Template.showList.helpers
  list: ->
    Lists.findOne(Session.get('listId'))

  items: ->
    Items.find({listId: Session.get('listId')}, {sort: {position: -1, score: -1}})

  itemsReady: ->
    Session.get('itemsReady')

  canAdd: ->
    list = Lists.findOne(Session.get('listId'))
    Meteor.user() && list && (list.userId == Meteor.userId() || list.open)

  couldAdd: ->
    !Meteor.user() && Lists.findOne(Session.get('listId')).open

Template.showList.events
  'submit .add-item': ->
      event.preventDefault()
      Items.insert(
        userId: Meteor.userId()
        listId: Session.get('listId'),
        text: $('#text').val()
        url: $('#url').val()
        upvoters: []
        downvoters: []
        points: 0
        position: 0
        createdAt: new Date()
        username: Lists.findOne(Session.get('listId')).username
        listSlug: Lists.findOne(Session.get('listId')).slug
        listName: Lists.findOne(Session.get('listId')).name
      )
      $('#text').val ''
      $('#url').val ''
