class Worker
  attr_accessor :queue
  def initialize(queue)
    self.queue = queue
  end

  def execute
    loop do
      args = queue.pop
      next unless args

      puts "got args #{args}"
      klass = args.shift.constantize
      klass.new.perform(*args)

    end
  end
end