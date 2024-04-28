require 'sidekiq-scheduler'

class MessageSchedulerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform

  end
end