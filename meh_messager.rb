require 'sinatra/base'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-observer'
require 'dm-types'
require './lib/core_extensions'
require './app/models/incoming_text_message'
require './app/models/incoming_text_message_observer'
require './app/models/paypal_ipn'
require './app/models/paypal_ipn_observer'
require './app/models/remote_request'
require './app/models/remote_incoming_text_message'
require './app/models/remote_paypal_ipn'

class MehMessager < Sinatra::Base

  set app_settings = YAML.load(
    File.read("config/#{environment.to_s}.yml")
  )

  # Tasks uris

  get '/tasks/ping' do
    200
  end

  put '/tasks/incoming_text_messages/:id' do
    incoming_text_message = IncomingTextMessage.get(params["id"])
    remote_payment_request = RemoteIncomingTextMessage.new(
      app_settings['remote_application']['uri']
    )
    remote_payment_request.create(incoming_text_message)
  end

  put '/tasks/paypal_ipns/:id' do
    incoming_text_message = PaypalIpn.get(params["id"])
    remote_payment_request = RemotePaypalIpn.new(
      app_settings['remote_application']['uri']
    )
    remote_payment_request.create(incoming_text_message)
  end

  get '/cron/ping' do
    5.times do |i|
      AppEngine::Labs::TaskQueue.add(
        nil,
        :url => "/tasks/ping",
        :method => 'GET',
        :countdown => (i + 1) * 10
      )
    end
  end

  # Publically available uris
  # SMS Global sends a get request so this is actually the create action
  get '/incoming_text_messages' do
    IncomingTextMessage.create(params)
  end

  post '/paypal_ipns' do
    PaypalIpn.create(params)
  end
end

