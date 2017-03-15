class SidepushQueue
  cattr_accessor :connection
  attr_accessor :channel

  class << self
    def get_new_jid
      "sidepush_jobs:#{connection.incr('sidepush_id')}"
    end
  end


  def initialize(channel)
    self.channel = channel
  end

  def push(args)
    jid = self.class.get_new_jid
    self.class.connection.set(jid, args.to_json)
    self.class.connection.lpush("jobs:#{channel}", jid)
    jid
  end

  def pop
    jid       = self.class.connection.brpop("jobs:#{channel}")
    json_args = self.class.connection.get(jid)
    JSON.parse(json_args) if json_args
  end
end