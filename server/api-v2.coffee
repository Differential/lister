RESTstop.configure(
  api_path: 'api/v2'
  use_auth: false
)

RESTstop.add(
  'lists',
  { method: 'GET', require_login: false },
  () ->
    lists = List.find().fetch()
    [ lists ]
)

