# Website

## Set Up on WSL (Ubuntu 18.04)

    git clone https://github.com/joejcollins/joejcollins.github.io.git ./
    sudo apt-get update
    sudo apt-get install ruby ruby-dev make build-essential
    sudo apt install zlibc zlib1g-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev
    sudo gem install jekyll bundler
    bundle install

To run

    bundle exec jekyll serve --host localhost --port 8080

To include drafts

    bundle exec jekyll serve --drafts --host localhost --port 8080

