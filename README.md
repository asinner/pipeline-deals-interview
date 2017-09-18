# README

pipeline-deals-interview is a Rails application that interacts with the PipelineDeals API. It displays
a column chart with aggregation totals for every stage.

## Prerequisites

- Ruby 2.4.1
- Yarn

First install the Rails dependencies:

```sh
bundle install
```

Next, install Javascript dependencies:

```sh
yarn
```

Then:

```sh
rails s
```

Then, you can view the application in your browser at http://localhost:3000.

## Production

In order to run the production server you will need to follow the steps above for running the development server.

Then:

```sh
rake assets:precompile
```

Then you can start the server:

```sh
RAILS_ENV=production SECRET_KEY_BASE=<your-ultra-secure-key> RAILS_SERVE_STATIC_FILES=true rails s
```
