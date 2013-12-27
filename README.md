### Contribute

```sh
# Install Meteor
$ curl https://install.meteor.com | /bin/sh

# Install Meteorite
$ npm install -g meteorite

# Install Meteorite pkgs
$ mrt
```

Sometimes some of the git submodules may need to be updated if you are getting Meteorite build errors. One submodule is `page.js` within `page-js-ie-support`. Go inside `/page.js` and do a `$ git checkout master`.

### Deploy

Lister.io is hosted on the Modulus nodejs platform. If you are not using the Differential Modulus account, you must:

1. Sign up for Modulus account at modulus.io
2. Create a new project, call it Lister
3. Create a new Database, call it Lister, create a user for the db, e.g. user / pass
4. Add the following ENV variables
  - MONGO_URL, you can get this from your projects Administration page, your user and pass is the db user. e.g. mongodb://user:pass@mongo.onmodulus.net:12345/jdie4i9
  - ROOT_URL, set this to your modulus project's url. e.g. http://lister-12345.onmodulus.net/


```sh
# Install Modulus CLI
npm install modulus -g

# Deploy to Modulus account
modulus deploy
```
