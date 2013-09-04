# Blog Engine
This is a simple file based blog engine built with [Sinatra](http://www.sinatrarb.com/)
based on the basic example from this excellent [book](http://shop.oreilly.com/product/0636920019664.do).

## Installation
Execute `$ bundle install` to install all required gems and their dependencies.

## Usage

### Running the Webserver
Execute `$ shotgun` to start up a the webserver. Visit `localhost:9393` in your browser to view the blog.

### Generating new articles
Simply add another markdown file to the articles/ directory and you're good to go.
To automatically generate a timestamped article template, execute `$ ruby scripts/generate_article.rb`
This feature is WIP.

