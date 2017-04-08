class UpdateCounterWorker
  include Sidepunch::Worker

  def perform(counter_name, update_type)
    Faraday.put("https://counter-as-a-service.herokuapp.com/#{counter_name}/#{update_type}")
  end

end
