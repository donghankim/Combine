# [Group 29] Combine: <a href="https://group29-combine.herokuapp.com/" target="_blank">Heroku Application Link</a>

* Jade Kaleel jik2124
* Donghan Kim dk3245
* Elia Lejzerowicz eel2157

## TODO:
All main functionalities have been implemented and tested. A few bugs and some design changes will be addressed before the final submission (proj-launch)
* ~~Fix MySQL and Postgres DB field type incompatibility issue -> look at createImdb function and difference between params and current_user.id~~
* Update form template (design)
* Add additional flash message colors
* Change freinds table view
* Convert recommendation view into card design

## Software Requirements
* Ruby Version: 2.6.6
* Rails Version: 6.1.7
* Node Version: v14.20.1
* Development DB: sqlite3 v1.4
* Production DB: postgres v1.4
* OS: Mac Monterey 12.5
* Heroku stack: 20

## Software Installations Guide
ALL packages were installed using homebrew. These steps will work on **M1/M2 macbooks**. However, for other mac variants some of these steps might not work at once.

```sh
# install rbenv and ruby-build
brew install rbenv ruby-build

# install ruby 2.6.6, and set to global version
RUBY_CFLAGS="-w" rbenv install 2.6.6
rbenv global 2.6.6

# rails 6.1.7 installation
gem install rails -v 6.1.7
rbenv rehash

# verify rails version with rails -v

# install sqlit3
brew install sqlite3

# install postrgesql
brew install postgresql
```

## Local Development
The following are instructions to run this application on your local machine
```sh
# cloning the repository
git clone https://github.com/donghankim/Combine.git
cd Combine

# install up gems
rm Gemfile.lock
bundle install

# set up local database
rake db:migrate

# start server on localhost:3000
rails server

# to run cucumber tests
cd Combine
rm -r coverage
cucumber

# to run rspec
cd Combine
rm -r coverage
rspec
```
If you get an error from running bundle install, try using **sudo bundle install**. This is not recommended, but will solve any permission errors you encounter.

## Heroku Helper
Application is hosted using Heroku eco dynos and mini Heroku Postgres DB.
```sh
# set heroku app stack version
$ heroku stack:set heroku-20

# to add heroku remote url
$ git remote add heroku https://git.heroku.com/app.git

# upload code to heroku server
$ git push heroku main

# clean heroku (postgres) db and populate seed data if needed
$ heroku restart; heroku pg:reset DATABASE --confirm group29-combine; heroku run rake db:migrate
$ heroku run rake db:seed

# view heoku server logs (tail)
$ heroku logs -t

# access postgres db (\q to quit)
$ heroku pg:psql
```

