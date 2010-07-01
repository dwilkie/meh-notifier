require 'sinatra/base'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-observer'
require 'dm-types'
require './app/models/incoming_text_message'

class MehMessager < Sinatra::Base
  post '/incoming_text_messages' do
    IncomingTextMessage.create(params)
  end
end

