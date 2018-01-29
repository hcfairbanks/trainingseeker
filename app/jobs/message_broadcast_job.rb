class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    Message.create! content: data["message"], conversation_id: data["conversation"], user_id: data["user"]
    ActionCable.server.broadcast "conversations_channel_#{data["conversation"]}", message: data['message']
  end
end
