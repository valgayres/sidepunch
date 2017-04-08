namespace :sidepunch do

  task run: :environment do
    Sidepunch::BackgroundWorker.new(Sidepunch::Queue.new('default')).execute
  end
end
