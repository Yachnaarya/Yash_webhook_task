class WebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook)
    puts "WebhookJob: #{webhook.inspect}"
  end
end
