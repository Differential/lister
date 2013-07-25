Template.item.helpers
  'isListOwner': ->
    Meteor.user().username == Session.get('username')

Template.item.events
  'click .delete': ->
    Items.remove(@_id)
