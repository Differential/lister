Template.newList.events

  'submit .newList': ->
    event.preventDefault()
    name = $('[name=name]')
    Lists.insert(
      username: Meteor.user().username
      name: name.val()
      slug: (name.val() || '').replace(/\W+/g, '-').toLowerCase()
    )
    name.val ''
    Meteor.Router.to('/lists')
