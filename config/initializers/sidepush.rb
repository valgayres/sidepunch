require 'sidepush_queue'
require 'sidepunch_worker'
require 'worker'

SidepushQueue.connection = Redis.new
