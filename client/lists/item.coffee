Template.listItem.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.listItem.helpers
  username: ->
    @username

Template.listItem.events
  'click .delete': ->
    Lists.remove(@_id)
