App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called after the server has received and processed the message
    # The line below appends the new message to other messages
    $('#message').append(data['message'])

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '#room_speaker', (event) ->
  if event.keyCode is 13 # return = send
    # Call speak from the method defined above
    App.room.speak event.target.value
    # Set input to be empty after the message gets to the server
    event.target.value = ''
    # Prevent form from reloading
    event.preventDefault()
