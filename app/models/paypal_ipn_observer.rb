class IncomingTextMessageObserver
  include DataMapper::Observer
  observe PaypalIpn

  # After it's created
  # create it at the remote application
  after :create do
    AppEngine::Labs::TaskQueue.add(
      nil,
      :url => "/tasks/paypal_ipns/#{self.id}",
      :method => 'PUT'
    )
  end
end

