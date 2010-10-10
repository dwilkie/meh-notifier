class TropoMessage
  def initialize(raw_json)
    @session_object = Tropo::Generator.parse(raw_json)
    @tropo_message = Tropo::Message.new(:tropo_session => @session_object)
    TropoIncomingTextMessage.create(@session_object) unless @tropo_message.outgoing?
  end

  def response
    if @tropo_message.outgoing?
      tropo = Tropo::Generator.new
      text = @tropo_message.text
      tropo.message(@tropo_message.response_params) do
        say :value => text
      end
      tropo.response
    end
  end
end

