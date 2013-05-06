Reveally
========

Alliance website for Eve Online

## Requirements
* ruby "2.0.0"

## Installation of the environment
You can use vagrant which configs are inside this project.

* Install [Vagrant](http://vagrantup.com)
* Install chef & librarian: `gem install chef librarian`
* Install the chef cookbooks: `librarian-chef install`
* Build the VM: `vagrant up`
* Login to the VM: `vagrant ssh`
* Provect is located at /vagrant folder: `cd /vagrant`.

When you are done, exit the VM and run the following command to suspend it until later: `vagrant suspend`

## Installation of the project
* `bundle install`
* `rake db:migrate`
* `rake db:seed`
* `rails s`
