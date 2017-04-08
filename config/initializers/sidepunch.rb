require 'sidepunch/queue'
require 'sidepunch/worker'
require 'sidepunch/background_worker'

Sidepunch::Queue.connection = Redis.new
