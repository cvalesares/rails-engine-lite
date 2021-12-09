# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# README

### Mod3 Solo Project: Rails Engine Lite
### Christian Valesares
---

"Rails Engine Lite" is an API for a fabricated eCommerce site. Full functionality can be found in the "API" section below.

## Schema

There are 6 tables with 5 one-to-many relationships:

<img width="658" alt="schema_little_esty_shop copy" src="https://user-images.githubusercontent.com/86392608/141384508-04b2a58d-8a04-4f84-b4e5-8ca4d0b80123.png">



## Tools Used:
- Rails 6.1.4.1
- Ruby 2.7.2
- PostgreSQL
- Factory Bot
- Faker
- jsonapi serializer
- rspec

## Setup

* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:{create, migrate, seed}`
* Run the test suite with `bundle exec rspec`.

## API

This API has multiple endpoints returning:
  * All merchants
  * All items
  * Instances of merchants & items
  * Full CRUD functionality for above
  * Keyword searches for above
