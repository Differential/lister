Meteor.startup ->
  Meteor.methods
   findListId: (username, slug) ->
     Lists.findOne(
       username: username
       slug: slug
     )._id
