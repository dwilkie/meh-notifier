module FakeWebHelper
  def register_remote_payment_request(method, status)
    FakeWeb.register_uri(
      method,
      %r|http://localhost:3000/payment_requests/\d+(?:\?[^\s\?]+)?|,
      :status => status
    )
  end

  def register_paypal_payment_request(options={})
    response = "HTTP/1.1 200 OK\r\nDate: Fri, 04 Jun 2010 16:55:36 GMT\r\nServer: Apache-Coyote/1.1\r\nX-PAYPAL-SERVICE-VERSION: 1.3.0\r\nX-EBAY-SOA-MESSAGE-PROTOCOL: NONE\r\nX-EBAY-SOA-RESPONSE-DATA-FORMAT: NV\r\nX-PAYPAL-SERVICE-NAME: {http://svcs.paypal.com/types/ap}AdaptivePayments\r\nX-PAYPAL-OPERATION-NAME: Pay\r\nX-EBAY-SOA-REQUEST-GUID: 12903e39-6ea0-abfc-49b7-0687ffffd0ac\r\nContent-Type: text/plain;charset=UTF-8\r\nSet-Cookie: Apache=10.191.196.11.1275670533834964; path=/; expires=Thu, 21-Apr-04 10:27:17 GMT\r\nVary: Accept-Encoding\r\nTransfer-Encoding: chunked\r\n\r\nresponseEnvelope.timestamp=2010-06-04T09%3A55%3A36.507-07%3A00&responseEnvelope.ack=Success&responseEnvelope.correlationId=1ddf86263c63d&responseEnvelope.build=1310729&payKey=AP-4MV83827NG0173616&paymentExecStatus=COMPLETED"

    FakeWeb.register_uri(
      :post,
      paypal_payments_uri,
      :response => response
    )
  end

  def remote_payment_request_uri(id, fields=nil)
    uri = URI.parse("http://localhost:3000/payment_requests/#{id}")
    uri.query = fields.to_query if fields
    uri.to_s
  end

  def paypal_payments_uri
    "https://svcs.sandbox.paypal.com/AdaptivePayments/Pay"
  end

  def paypal_response_payload(payload)
    payload = payload.from_query
    {"payment_response" => payload}.to_query
  end

  def internal_errors_payload(payload)
    payload = payload.from_query
    {"errors" => payload}.to_query
  end

  def notification_payload(id, payload)
    payload = payload.from_query.merge("id" => id.to_s)
    {"payment_request" => payload}.to_query
  end
end

