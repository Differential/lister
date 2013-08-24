sitemaps.add "/sitemap.xml", ->
  pages = []
  lists = Lists.find().fetch()
  _.each lists, (list) ->
    pages.push
      page: list.username + '/' + list.slug
      lastmod: list.updatedAt
  pages
