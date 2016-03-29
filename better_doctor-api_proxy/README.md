# BetterDoctor Platform Engineer Coding Challenge

__Challenge specs__:

Your goal is to create a simple Rails API that proxies the BetterDoctor API. Why? For science! We believe one of best ways to understand how an engineer thinks is to read through their code.

Let’s get down to specifics:

* Implement a single endpoint in a rails api application: `/api/v1/doctors/search?name=<name to search for>`
* The api should be able to search the BetterDoctor API, by name, for a doctor using the 'name' field in the BetterDoctor API.
* Cache any results for a given query. Pass all results for the given query back to the caller. Any given cache record should expire after 30 minutes.
*  Use Rails (4.2 or higher), Ruby (2.2 or higher) and a HTTP framework of your choosing.

## Preliminary

Must be using Ruby v2.2.3.

```shell
$ bundle install
```

```shell
$ bundle exec bin/spring binstub --all
```

To list all API routes:

```shell
$ bundle exec bin/rake api:routes
```

To start the server:

```shell
$ bundle exec bin/rails s
```

To boot into an executable console with all dependencies loaded (loaded with Pry):

```shell
$ bundle exec bin/rails c
```

__Each request that requires an API access key must be passed in a header__: `X-Api-Key`

## API

To search for doctors:

```shell
$ curl -X GET -H "X-Api-Key: YOUR_API_KEY" http://localhost:3000/api/v1/doctors/search?limit=10&location=37.773%2C-122.413%2C100&skip=0&user_location=37.773%2C-122.413
```

The default parameter values are the same as the BetterDoctor public API.

## Tests

To run integration tests:

```shell
$ API_KEY="REDACTED" bundle exec bin/rake spec
```
