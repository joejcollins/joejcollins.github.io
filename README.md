# Website

## Set Up on WSL (Ubuntu 18.04)

Slightly convoluted because `nokogiri` requires some help to install on WSL.  Check out <https://www.richard-banks.org/2016/08/jekyll-on-bash-on-ubuntu-on-windows.html> for more detail.

    git clone https://github.com/joejcollins/joejcollins.github.io.git ./
    sudo apt-get update
    sudo apt-get install ruby ruby-dev make build-essential
    sudo apt install zlibc zlib1g-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev
    sudo gem install jekyll bundler
    bundle config build.nokogiri --use-system-libraries
    bundle install

To run

    bundle exec jekyll serve --host 0.0.0.0 --port 8080

To include drafts

    bundle exec jekyll serve --drafts --host 0.0.0.0 --port 8080

