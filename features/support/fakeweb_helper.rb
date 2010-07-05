module FakeWebHelper
  def register_remote_incoming_text_messages_uri(status)
    FakeWeb.register_uri(
      :post,
      incoming_text_messages_uri,
      :status => status
    )
  end

  def incoming_text_messages_uri
    "http://localhost:3000/incoming_text_messages"
  end
end

