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

## Setup
```
cd [root]

brew install rbenv
# do the caveats
rbenv install [.ruby-version here]
# restart shell, check that `which ruby` points at correct version

brew install nvm
# do the caveats
nvm install [.nvmrc version here]
nvm use
# restart shell, check that `which node` points at correct version

bundle
rspec
rails s
```
