require 'sinatra/base'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-observer'
require 'dm-types'
require 'extlib_lite'
require './app/models/local_resource'
require './app/models/local_resource_observer'
require './app/models/incoming_text_message'
require './app/models/text_message_delivery_receipt'
require './app/models/paypal_ipn'
require './app/models/remote_request'

class MehNotifier < Sinatra::Base

  set app_settings = YAML.load(
    File.read("config/#{environment.to_s}.yml")
  )

  # Tasks uris

  # Keep me alive
  get '/tasks/ping' do
    200
  end

  put '/tasks/:resources/:id' do
    local_resource = params[:resources].classify.constantize.get(params["id"])
    remote_request = RemoteRequest.new(
      app_settings['remote_application']['uri']
    )
    remote_request.create(local_resource)
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
    "OK"
  end

  # SMS Global sends a get request so this is actually the create action
  get '/text_message_delivery_receipts' do
    TextMessageDeliveryReceipt.create(params)
    "OK"
  end

  post '/paypal_ipns' do
    PaypalIpn.create(params)
  end
end

