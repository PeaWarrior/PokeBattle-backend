# PokeBattle [Backend]


PokeBattle is a Pokemon team builder web application with real-time competitive battling against other users.

This is the Ruby on Rails API for PokeBattle. You can access the Frontend [here](https://github.com/PeaWarrior/PokeBattle-backend).


## Prerequisites

1. Install [Homebrew](https://brew.sh/)

    ```console
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ```

2. Install [Ruby](https://www.ruby-lang.org/en/)

    ```console
    $ brew install ruby
    ```

3. Install [Rails](https://rubyonrails.org/)
    ```console
    $ gem install rails
    ```

4. Install [PostgreSQL](https://www.postgresql.org/)

    ```console
    $ brew install postgresql
    ```

## Getting Started

1. Clone this repository and `cd` into the directory

2. Install dependencies

    ```console
    $ bundle install
    ```
    
3. Initiate the database, migrate and seed

    ```console
    $ rails db:create db:migrate db:seed
    ```

4. Start the rails server

    ```console
    $ rails s -p 3001
    ```