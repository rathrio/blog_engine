$LOAD_PATH.unshift 'lib'

require 'blog'
require 'gossip'

map('/') { run Blog }
map('/gossip') { run Gossip }
