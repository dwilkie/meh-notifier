class TropoMessage
  def initialize(raw_json, request_params = {})
    begin
      @session_object = Tropo::Generator.parse(raw_json)
    rescue JSON::ParserError
    end
    if @session_object
      @tropo_message = Tropo::Message.new(@session_object)
      TropoIncomingTextMessage.create(
        :session_object => @session_object,
        :request_params => request_params
      ) unless @tropo_message.outgoing?
    end
  end

  def response
    if @tropo_message && @tropo_message.outgoing?
      tropo = Tropo::Generator.new
      text = @tropo_message.text
      tropo.message(@tropo_message.response_params) do
        say :value => text
      end
      tropo.response
    end
  end
end

