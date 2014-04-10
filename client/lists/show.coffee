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

  isFavorited: (list) ->
    _.contains(list.favorited, Meteor.userId())

Template.showList.events
  'click .for-favorite': (event) ->
    event.preventDefault()
    if @favorited and _.contains(@favorited, Meteor.userId())
      @pull
        favorited: Meteor.userId()    
    else
      @push 
        favorited: Meteor.userId()

  'submit .add-item, keyup form.add-item': (event) ->
    event.preventDefault()
    unless event.type is 'submit' or event.type is 'keyup' and event.ctrlKey and event.keyCode is 13
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
