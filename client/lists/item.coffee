Template.listItem.helpers
  username: ->
    @username

Template.listItem.events
  'click .delete': ->
    Lists.remove(@_id)
