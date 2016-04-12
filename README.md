# devtest solution

## Installation
```bash
bundle install
rake db:create
rake db:migrate
rake db:seed
```

## Starting server
```bash
rails s
```

## API paths

* Public API: http://localhost:3000/v1/public_api
* Private API: http://localhost:3000/v1/private_api

## Authorization

Use 'secret_token' in Authorization header.

```
Authorization: Token token="secret_token"
```

It's generated in seeds, it may be upgraded in future (generation of random token, token expiration etc.).

## Specs

I tested the most important things (requests, panel providers services) with Rspec, FactoryGirl and VCR.

```
rspec
```

## Notes

1. I left `external_id` in `Location` and `TargetGroup` blank. I assume it could be used for many to many relations (I used inner tables) or used only for storing some ids in a client application, but it wasn't specified.

2. I assumed that `secret_code` fields should be displayed only in a private API, but it wasn't specified as well, so it can be an overassumption.

3. I assumed that I should list locations from locations groups, because there is no direct relation between Country and Location in models specification.
