Handlebars.registerHelper "date", (date) ->
  if date
    dateObj = new Date(date)
    return $.timeago(dateObj).replace(/\ /g, "\u00a0")
  "some time ago"
