Template.home.rendered = ->
  $('body').css('background-color', Session.get('color'))

  setTimeout ->
    $('#app-store a').css('top', '20px')
  , 1000

Template.home.helpers
  lists: ->
    List.where({}, sort:{updatedAt:-1})

  searchItems: ->
    regx = new RegExp(Session.get('query'), "i")
    Item.find(text: regx)

  searchItemsNum: ->
    regx = new RegExp(Session.get('query'), "i")
    Item.find(text: regx).count()

  searchLists: ->
    regx = new RegExp(Session.get('query'), "i")
    console.log(List.find(name: regx).fetch())
    List.find(name: regx)

  searchListsNum: ->
    regx = new RegExp(Session.get('query'), "i")
    List.find(name: regx).count()

  query: ->
    Session.get('query')

Template.homeList.helpers
  mostRecentItemUser: ->
    item = @mostRecentItem()
    if item
      item.username

  mostRecentItemText: ->
    item = @mostRecentItem()
    if item
      item.text


