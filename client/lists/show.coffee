Template.showList.rendered = ->
  $('body').css('background-color', Session.get('color'))
  Session.set('name', List.first(Session.get('listId')).name)
  document.title = Session.get('name') + " ~ by " + Session.get('username') + " ~ lister.io"

Template.showList.helpers
  list: ->
    List.first(Session.get('listId'))

  items: ->
    list = List.first(Session.get('listId'))
    list.related('items', {sort: {score: -1}}) if list

  canAdd: ->
    list = List.first(Session.get('listId'))
    Meteor.user() && list && (list.userId == Meteor.userId() || list.open)

  couldAdd: ->
    list = List.first(Session.get('listId'))
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
        # There is a problem with minimongoid dates, which messes up sorting.
        # See https://github.com/Exygy/minimongoid/issues/6
        Item._collection.insert(
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
          username: List.first(Session.get('listId')).username
          listSlug: List.first(Session.get('listId')).slug
          listName: List.first(Session.get('listId')).name
        )
        $('#text').val ''
        $('#text').focus()
        $('#url').val ''
      else
        alert 'Be more descriptive.'
