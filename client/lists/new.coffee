Template.newList.events

  'submit .newList': ->
    event.preventDefault()
    name = $('[name=name]')
    Lists.insert(
      name: name.val()
    )
    name.val ''
