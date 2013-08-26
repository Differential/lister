Template.showList.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.showList.helpers
  list: ->
    Lists.findOne(Session.get('listId'))

  items: ->
    Items.find({listId: Session.get('listId')}, {sort: {position: -1, score: -1}})

  canAdd: ->
    list = Lists.findOne(Session.get('listId'))
    Meteor.user() && list && (list.userId == Meteor.userId() || list.open)

  couldAdd: ->
    list = Lists.findOne(Session.get('listId'))
    !Meteor.user() && list && list.open

Template.showList.events
  'submit .add-item': (event) ->
      event.preventDefault()
      url = $('#url')
      urlValue =
        if url.val().match(/^http/) || url.val().match(/^https/)
          url.val()
        else
          if url.val() == ''
            url.val()
          else
            'http://' + url.val()

      if $('#text').val().length > 2
        Items.insert(
          userId: Meteor.userId()
          itemUsername: Meteor.user().username
          listId: Session.get('listId'),
          text: $('#text').val()
          url: urlValue
          upvoters: []
          downvoters: []
          score: 0
          position: 0
          createdAt: new Date()
          username: Lists.findOne(Session.get('listId')).username
          listSlug: Lists.findOne(Session.get('listId')).slug
          listName: Lists.findOne(Session.get('listId')).name
        )
        $('#text').val ''
        $('#text').focus()
        $('#url').val ''
      else
        alert 'Be more descriptive.'
