class Worker
  attr_accessor :queue
  def initialize(queue)
    self.queue = queue
  end

  def execute
    args, klass = nil, nil
    loop do
      args = queue.pop
      next unless args

      klass = args.shift.constantize
      klass.new.perform(*args)

    end
  rescue => error
    puts "An error occurred when processing #{klass} with args #{args} : #{error}"
    retry
  end
end