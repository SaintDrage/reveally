Reveally
========

Alliance website for Eve Online

## Requirements
* Ruby 2.0.0
* Ruby On Rails 4.0.0
* A database engine, MySQL, PgSQL or SQLite3

## Dev Environment
You can use vagrant which configs are inside this project.

* Install [Vagrant](http://vagrantup.com)
* Install chef & librarian: `gem install chef librarian`
* Install the chef cookbooks: `librarian-chef install`
* Build the VM: `vagrant up`
* Login to the VM: `vagrant ssh`
* Provect is located at /vagrant folder: `cd /vagrant`.

When you are done, exit the VM and run the following command to suspend it until later: `vagrant suspend`

## Install Reveally
Installing Reveally is trivial, provided you follow the following steps:

    $ bundle install
    $ rake db:migrate
    $ rake db:seed
    $ rails s
    
You can now access Typo to http://yourdomain:3000

That’s all!
