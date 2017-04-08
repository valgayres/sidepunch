module Sidepunch
  class BackgroundWorker
    attr_accessor :queue,
                  :logger
    def initialize(queue)
      self.queue = queue
      self.logger = Logger.new(STDOUT)
      puts Rails.logger.level
      self.logger.level = Rails.logger.level
    end

    def execute
      args, klass = nil, nil
      loop do
        args = queue.pop
        next unless args

        klass = args.shift.constantize
        logger.info "Performing #{klass} with arguments #{args}"
        t0 = Time.zone.now
        klass.new.perform(*args)
        t1 = Time.zone.now
        logger.info "#{klass} execution done in #{(t1 - t0).round(3)}s"
      end
    rescue => error
      logger.error "An error occurred when processing #{klass} with args #{args} : #{error}"
      retry
    end
  end
end