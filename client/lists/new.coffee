Template.newList.events

  'submit .newList': ->
    event.preventDefault()
    name = $('[name=name]')
    open = $('[name=open]')
    Lists.insert(
      userId: Meteor.userId()
      username: Meteor.user().username
      name: name.val()
      open: open.is(':checked')
      slug: (name.val() || '').replace(/\W+/g, '-').toLowerCase()
      createdAt: new Date()
    )
    name.val ''
    Meteor.Router.to('/lists')
