require './env'
require 'csv'

getter = Getter.new
things = getter.get_all_genres
getter.write_csv things
