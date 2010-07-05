class IncomingTextMessageObserver
  include DataMapper::Observer
  observe IncomingTextMessage

  # After it's created
  # create it at the remote application
  after :create do
    AppEngine::Labs::TaskQueue.add(
      nil,
      :url => "/tasks/incoming_text_messages/#{self.id}",
      :method => 'PUT'
    )
  end
end

