Template.item.rendered = ()->
  $("input.color").show().spectrum({
    showPaletteOnly: true,
    showPalette:true,
    color: Session.get('color'),
    palette: [
        ['lightblue', 'lightgreen', 'lightgray', 'pink', '#f4ff44', '#ffc350', '#db5858', '#add853',
         '#83afcc', '#8d97bb', '#a68dbb']
    ],
    change: (color)->
      color = color.toHexString()
      if color == ''
        Meteor.users.update(
          {_id: Meteor.userId()},
          { $unset: { 'profile.color': '' } }
        )
        color = '#'
        _(6).times -> color += (Math.floor(Math.random() * 7))
        Session.set('color', color)
        $('body').css('background-color', color)

      else
        Session.set('color', color)
        $('body').css('background-color', Session.get('color'))

        Meteor.users.update(
          {_id: Meteor.userId()},
          { $set: { 'profile.color': Session.get('color') } }
        )
  });
