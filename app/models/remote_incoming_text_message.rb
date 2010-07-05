# Represents the remote IncomingTextMessage resource
class RemoteIncomingTextMessage
  def initialize(remote_application_uri)
    @remote_application_uri = remote_application_uri
  end

  def create(incoming_text_message)
    uri = URI.join(
      @remote_application_uri,
      "incoming_text_messages"
    )
    params = incoming_text_message.params
    params = {"incoming_text_message" => params}.to_query
    AppEngine::URLFetch.fetch(
      uri.to_s,
      :payload => params,
      :method => 'POST',
      :follow_redirects => false,
      :headers => {"Content-Type" => "application/x-www-form-urlencoded"}
    ).code == "200" ? incoming_text_message.destroy : nil
  end
end

