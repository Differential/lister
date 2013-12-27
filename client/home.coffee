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
    Item.where(text: regx)

  searchItemsNum: ->
    regx = new RegExp(Session.get('query'), "i") 
    Item.find(text: regx).count()

  searchLists: ->
    regx = new RegExp(Session.get('query'), "i") 
    List.where(name: regx)

  searchListsNum: ->
    regx = new RegExp(Session.get('query'), "i") 
    List.find(name: regx).count()

Template.homeListRow.helpers
  mostRecentItemUser: ->
    item = @mostRecentItem()
    if item
      item.username

  mostRecentItemText: ->
    item = @mostRecentItem()
    if item
      item.text
    
Handlebars.registerHelper 'highlightQuery', (str) ->
    q = Session.get('query').toLowerCase()
    ql = q.length
    index = str.toLowerCase().indexOf(q)
    pre = str.substring(0, index)
    match = str.substr(index, ql)
    post = str.substring(index + ql)
    pre + "<span class='highlight'>#{match}</span>" + post
    
Handlebars.registerHelper 'query', () ->
    Session.get('query')


