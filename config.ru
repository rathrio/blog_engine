$LOAD_PATH.unshift 'lib'

require 'blog'

map('/') { run Blog }
