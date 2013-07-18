Template.home.helpers
  items: ->
    Items.find({}, sort:{createdAt:-1})