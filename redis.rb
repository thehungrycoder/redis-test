require 'bundler'
Bundler.require

require 'active_support/all'
require 'csv'
require 'json'
require 'pp'

redis = Redis.new(:port => 6379)

#store values
csv = CSV.foreach('./bodyfat.csv', {:headers => true, :header_converters => :symbol, :skip_blanks => true}) do |row|
  redis.set("users.#{row[:id]}", row.to_hash.to_json)
end

#retrieve values
user = redis.get('users.101')

if user.present?
  user = JSON.parse(user)
  pp user
end


