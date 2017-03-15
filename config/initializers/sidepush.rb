require 'queue'
require 'worker'

Queue.connection = Redis.new
