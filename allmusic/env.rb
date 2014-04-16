require 'rubygems'
require 'bundler'
require 'yaml'

Bundler.setup
Bundler.require

require './getter'

CONFIG = YAML.load_file './config.yml'
