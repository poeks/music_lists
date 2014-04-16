require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require

require './getter'

CONFIG = YAML.load_file './config.yml'
