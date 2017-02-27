class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # broadcast message so that all subscribers can have access to the message.
    ActionCable.server.broadcast 'room_channel', message: render_message(message)
  end

  private
    def render_message(message)
      # This is also a new feature in Rails 5. The controller renderer has been
      # extracted from the controller instance and can now be called as a class
      # method
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end
end
