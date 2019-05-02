require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'cheerups'
}

ActiveRecord::Base.establish_connection(options)
