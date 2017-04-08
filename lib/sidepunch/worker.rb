module Sidepunch
  module Worker
    extend ActiveSupport::Concern

    included do |base|
      def base.perform_async(*args)
        jid = Queue.new('default').push([self.to_s, *args])
        Rails.logger.info "pushing in queue with jid #{jid}"
      end
    end
  end
end