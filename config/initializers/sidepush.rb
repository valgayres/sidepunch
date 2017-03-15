require 'sidepush_queue'
require 'worker'

SidepushQueue.connection = Redis.new
