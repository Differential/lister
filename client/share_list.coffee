Template.shareLists.rendered = ->
  Meteor.Loader.loadJs("//connect.facebook.net/en_US/all.js")

  # Facebook
  base = 'https://www.facebook.com/sharer/sharer.php'
  url = encodeURIComponent(location.origin + location.pathname)
  title = encodeURIComponent($('#fb-share').data('name'))
  summary = encodeURIComponent('I made a list!')
  image = encodeURIComponent('http://png-3.findicons.com/files/icons/1579/devine/256/list.png')
  href = "#{base}?s=100&p[url]=#{url}&p[title]=#{title}&p[summary]=#{summary}&p[images][0]=#{image}"

  $('#fb-share').attr('href', href)

  # Twitter
  base = 'https://twitter.com/intent/tweet'
  url = encodeURIComponent(location.origin + location.pathname)
  via = 'listerio'
  text = encodeURIComponent('I made a list: ' + $('#tw-share').data('name'))
  href = "#{base}?url=#{url}&via=#{via}&text=#{text}"

  $('#tw-share').attr('href', href)
  
  # Google
  base = 'https://plus.google.com/share'
  url = encodeURIComponent(location.origin + location.pathname)
  href = "#{base}?url=#{url}"

  $('#gp-share').attr('href', href)
 
Template.shareLists.helpers
  username: ->
    Session.get('username')

  list: ->
    Lists.findOne(Session.get('listId'))
