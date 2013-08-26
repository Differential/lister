Template.footer.helpers
  color: ->
    Session.get('color')

Template.footer.events
  'change .color': (event) ->
    if $(event.target).val() == ''
      Meteor.users.update(
        {_id: Meteor.userId()},
        { $unset: { 'profile.color': '' } }
      )
      color = '#'
      _(6).times -> color += (Math.floor(Math.random() * 7))
      Session.set('color', color)
      $('body').css('background-color', color)

    else
      Session.set('color', $(event.target).val())
      $('body').css('background-color', Session.get('color'))

      Meteor.users.update(
        {_id: Meteor.userId()},
        { $set: { 'profile.color': Session.get('color') } }
      )
