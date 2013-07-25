Template.listItem.helpers
  username: ->
    Meteor.user().username

Template.listItem.events
  'click .delete': ->
    Lists.remove(@_id)
