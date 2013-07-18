Template.showList.helpers
  list: ->
    Lists.findOne(Session.get('listId'))

  items: ->
    Items.find(listId: Session.get('listId'))
  
  itemsReady: ->
    Session.get('itemsReady')

Template.showList.events
  'submit .add-item': ->
      event.preventDefault()
      text = $('#newItem')
      Items.insert(
        listId: Session.get('listId'),
        text: text.val()
      )
      text.val ''
