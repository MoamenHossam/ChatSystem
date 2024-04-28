require 'sidekiq-scheduler'

class ApplicationSchedulerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    apps = Application.all
    apps.each do |app|
        app.chats_count = Chat.where(application_token: app.token).count
        app.save
    end
  end
end