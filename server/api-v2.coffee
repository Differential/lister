RESTstop.configure(
  api_path: 'api/v2'
  use_auth: true
)

#
# Lists
#

RESTstop.add 'lists', method: 'GET', () ->
  [ List.all() ]

RESTstop.add 'lists/:id', method: 'GET', () ->
  [ List.first @params.id ]

RESTstop.add 'lists/:id/items', method: 'GET', () ->
  [ Item.where listId: @params.id ]

#
# Items
#

RESTstop.add 'items/:id', method: 'GET', () ->
  [ Item.first @params.id ]

