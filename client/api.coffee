Template.api.rendered = ->
  clip = new ZeroClipboard($('#copy-trigger'), {
    moviePath: '/ZeroClipboard.swf'
  })

  clip.on 'complete', ->
    $('#copy-trigger').tooltip('show')
    setTimeout ->
      $('#copy-trigger').tooltip('hide')
    , 1000

Template.api.helpers
  'key': -> if Meteor.user().profile then Meteor.user().profile.apiKey

Template.api.events

  'submit form': (e) ->
    e.preventDefault()
    Meteor.call('updateApiKey', (err, key) ->
      $('[name=key]').val(key)
    )
