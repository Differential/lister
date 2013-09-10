sitemaps.add "/sitemap.xml", ->
  pages = []
  lists = List.find().fetch()
  _.each lists, (list) ->
    pages.push
      page: list.username + '/' + list.slug
      lastmod: list.updatedAt
  pages
