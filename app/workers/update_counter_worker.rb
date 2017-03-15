class UpdateCounterWorker
  #include Sidekiq::Worker

  def perform(counter_name, update_type)
    Faraday.put("https://counter-as-a-service.herokuapp.com/#{counter_name}/#{update_type}")
  end

  def self.perform_async(*args)
    jid = SidepushQueue.new('default').push(['UpdateCounterWorker', *args])
    Rails.logger.info "pushing in queue with jid #{jid}"
  end
end
