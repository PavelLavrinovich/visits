# frozen_string_literal: true

require 'sqlite3'
require 'active_record'
require 'activerecord-import'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)
