namespace :sidepunch do

  task run: :environment do
    Worker.new(SidepushQueue.new('default')).execute
  end
end
