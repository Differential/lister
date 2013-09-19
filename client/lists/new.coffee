Template.newList.rendered = ->
  $('body').css('background-color', Session.get('color'))
  document.title = "Add list ~ lister.io"

Template.newList.events
  'submit .newList': (event) ->
    event.preventDefault()
    name = $('[name=name]')
    open = $('[name=open]')

    slug = (name.val() || '').replace(/\W+/g, '-').toLowerCase()

    if slug.substr(-1) is '-'
      slug = slug.substr(0, slug.length - 1)

    # There is a problem with minimongoid dates, which messes up sorting.
    # See https://github.com/Exygy/minimongoid/issues/6
    List._collection.insert
      userId: Meteor.userId()
      username: Meteor.user().username
      name: name.val()
      open: open.is(':checked')
      slug: slug
      createdAt: new Date()
      updatedAt: new Date()

    name.val ''
    Router.go('/lists')
