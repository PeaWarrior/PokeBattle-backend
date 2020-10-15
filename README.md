![PokéBattle](./logo.png)
# Rails API Backend

PokéBattle, inspired by the original Pokémon games, is a Pokémon battle game where players are able to create their own teams and battle each other.

This is the Ruby on Rails API for PokéBattle. You can access the Frontend [here](https://github.com/PeaWarrior/PokeBattle-frontend).


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
    This will start the Rails Backend API on port 3001.
    
## License
PokéBattle is released under the [MIT License](https://opensource.org/licenses/MIT).
<br>
Pokémon and Pokémon character names are trademarks of Nintendo.
