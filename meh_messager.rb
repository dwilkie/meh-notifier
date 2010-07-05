require 'sinatra/base'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-observer'
require 'dm-types'
require './lib/core_extensions'
require './app/models/incoming_text_message'
require './app/models/remote_incoming_text_message'
require './app/models/incoming_text_message_observer'

class MehMessager < Sinatra::Base

  set app_settings = YAML.load(
    File.read("config/#{environment.to_s}.yml")
  )

  put '/tasks/incoming_text_messages/:id' do
    incoming_text_message = IncomingTextMessage.get(params["id"])
    remote_payment_request = RemoteIncomingTextMessage.new(
      app_settings['remote_application']['uri']
    )
    remote_payment_request.create(incoming_text_message)
  end

  # SMS Global sends a get request so this is actually the create action
  get '/incoming_text_messages' do
    IncomingTextMessage.create(params)
  end
end

