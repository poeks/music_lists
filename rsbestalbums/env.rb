require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require

CONFIG = YAML.load_file './config.yml'
