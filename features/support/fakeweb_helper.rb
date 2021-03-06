module FakeWebHelper
  def register_remote_incoming_text_messages_uri(status)
    FakeWeb.register_uri(
      :post,
      incoming_text_messages_uri,
      :status => status
    )
  end

  def register_remote_text_message_delivery_receipts_uri(status)
    FakeWeb.register_uri(
      :post,
      text_message_delivery_receipts_uri,
      :status => status
    )
  end

  def register_remote_paypal_ipns_uri(status)
    FakeWeb.register_uri(
      :post,
      paypal_ipns_uri,
      :status => status
    )
  end

  def register_offline_request
    AppEngine::URLFetch.register_offline_request
  end

  def incoming_text_messages_uri
    "http://localhost:3000/incoming_text_messages"
  end

  def text_message_delivery_receipts_uri
    "http://localhost:3000/text_message_delivery_receipts"
  end

  def paypal_ipns_uri
    "http://localhost:3000/paypal_ipns"
  end

end

